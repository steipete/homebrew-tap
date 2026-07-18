from __future__ import annotations

import importlib.util
import json
import os
import pathlib
import sys
import tempfile
import unittest
import urllib.error
from unittest import mock


ROOT = pathlib.Path(__file__).resolve().parents[1]
SCRIPT = ROOT / ".github" / "scripts" / "update_formula.py"
SPEC = importlib.util.spec_from_file_location("update_formula", SCRIPT)
assert SPEC and SPEC.loader
update_formula = importlib.util.module_from_spec(SPEC)
SPEC.loader.exec_module(update_formula)


class UpdateFormulaTest(unittest.TestCase):
    def run_main_in_temp_tap(self, formula_text: str, *args: str) -> str:
        original_cwd = os.getcwd()
        with tempfile.TemporaryDirectory() as directory:
            root = pathlib.Path(directory)
            formula_dir = root / "Formula"
            formula_dir.mkdir()
            formula_path = formula_dir / "sonoscli.rb"
            formula_path.write_text(formula_text)

            os.chdir(root)
            try:
                with (
                    mock.patch.object(update_formula, "sha256", return_value="c" * 64),
                    mock.patch.object(sys, "argv", ["update_formula.py", *args]),
                ):
                    update_formula.main()
                return formula_path.read_text()
            finally:
                os.chdir(original_cwd)

    def test_sha256_retries_missing_release_asset_with_backoff(self) -> None:
        response = mock.MagicMock()
        response.__enter__.return_value.read.side_effect = [b"artifact", b""]
        missing = urllib.error.HTTPError(
            "https://github.com/openclaw/Peekaboo/releases/download/v1.0.0/peekaboo.tar.gz",
            404,
            "Not Found",
            {},
            None,
        )

        with (
            mock.patch.object(update_formula.urllib.request, "urlopen", side_effect=[missing, response]),
            mock.patch.object(update_formula.time, "sleep") as sleep,
        ):
            digest = update_formula.sha256(missing.url, attempts=2, initial_backoff=3)

        self.assertEqual(digest, "c7c5c1d70c5dec4416ab6158afd0b223ef40c29b1dc1f97ed9428b94d4cadb1c")
        sleep.assert_called_once_with(3)

    def test_sha256_does_not_retry_non_release_404(self) -> None:
        missing = urllib.error.HTTPError(
            "https://github.com/openclaw/Peekaboo/archive/refs/tags/v1.0.0.tar.gz",
            404,
            "Not Found",
            {},
            None,
        )

        try:
            with (
                mock.patch.object(update_formula.urllib.request, "urlopen", side_effect=missing),
                mock.patch.object(update_formula.time, "sleep") as sleep,
                self.assertRaises(urllib.error.HTTPError),
            ):
                update_formula.sha256(missing.url, attempts=2, initial_backoff=3)
        finally:
            missing.close()

        sleep.assert_not_called()

    def test_explicit_assets_render_exact_names_after_download_verification(self) -> None:
        formula = '''class Sonoscli < Formula
  homepage "https://github.com/steipete/sonoscli"
  version "0.3.1"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/steipete/sonoscli/releases/download/v0.3.1/old-darwin-arm64.tar.gz"
      sha256 "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"
    else
      url "https://github.com/steipete/sonoscli/releases/download/v0.3.1/old-darwin-amd64.tar.gz"
      sha256 "bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/steipete/sonoscli/releases/download/v0.3.1/old-linux-arm64.tar.gz"
      sha256 "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"
    end
    on_intel do
      url "https://github.com/steipete/sonoscli/releases/download/v0.3.1/old-linux-amd64.tar.gz"
      sha256 "bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb"
    end
  end

  resource "completion" do
    url "https://example.test/completion.tar.gz"
    sha256 "dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd"
  end

  def install
    bin.install "sonoscli"
  end
end
'''
        assets = {
            target: {"name": f"sonoscli_0.3.2_custom_{target}_v8.0.tar.gz", "sha256": "c" * 64}
            for target in update_formula.RELEASE_TARGETS
        }

        updated = self.run_main_in_temp_tap(
            formula,
            "--formula",
            "sonoscli",
            "--tag",
            "v0.3.2",
            "--repository",
            "steipete/sonoscli",
            "--assets-json",
            json.dumps(assets),
        )

        self.assertIn('version "0.3.2"', updated)
        self.assertIn('url "https://example.test/completion.tar.gz"', updated)
        self.assertIn('sha256 "' + "d" * 64 + '"', updated)
        for item in assets.values():
            self.assertIn(item["name"], updated)
            self.assertIn(f'sha256 "{item["sha256"]}"', updated)

    def test_explicit_assets_contract_is_atomic_and_must_rehash(self) -> None:
        self.assertIsNone(update_formula.parse_explicit_assets(None))
        assets = {
            target: {"name": f"fixture-{target}.tar.gz", "sha256": "a" * 64}
            for target in update_formula.RELEASE_TARGETS
        }
        incomplete = dict(assets)
        incomplete.pop("linux_arm64")
        with self.assertRaisesRegex(SystemExit, "must contain exactly"):
            update_formula.parse_explicit_assets(json.dumps(incomplete))

        parsed = update_formula.parse_explicit_assets(json.dumps(assets))
        assert parsed is not None
        with (
            mock.patch.object(update_formula, "sha256", return_value="b" * 64),
            self.assertRaisesRegex(SystemExit, "SHA-256 mismatch"),
        ):
            update_formula.verify_explicit_assets("steipete/fixture", "v1.2.3", parsed)

    def test_updates_duplicate_source_url_checksums_in_stanza(self) -> None:
        text = '''class Camsnap < Formula
  version "0.2.0"

  on_linux do
    on_intel do
      url "https://github.com/steipete/camsnap/archive/refs/tags/v0.2.0.tar.gz"
      sha256 "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"
    end

    on_arm do
      url "https://github.com/steipete/camsnap/archive/refs/tags/v0.2.0.tar.gz"
      sha256 "bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb"
    end
  end

  def install
  end
end
'''

        updated = update_formula.update_url_and_sha_in_stanza(
            text,
            "on_linux",
            "https://github.com/steipete/camsnap/archive/refs/tags/v0.3.0.tar.gz",
            "cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc",
            "0.3.0",
        )

        self.assertEqual(updated.count("v0.3.0.tar.gz"), 2)
        self.assertEqual(updated.count("cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc"), 2)

    def test_rejects_different_architecture_urls_in_one_stanza(self) -> None:
        text = '''class Example < Formula
  version "1.0.0"

  on_linux do
    on_intel do
      url "https://github.com/steipete/example/releases/download/v1.0.0/example_1.0.0_linux_amd64.tar.gz"
      sha256 "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"
    end

    on_arm do
      url "https://github.com/steipete/example/releases/download/v1.0.0/example_1.0.0_linux_arm64.tar.gz"
      sha256 "bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb"
    end
  end

  def install
  end
end
'''

        with self.assertRaises(SystemExit) as raised:
            update_formula.update_url_and_sha_in_stanza(
                text,
                "on_linux",
                "https://github.com/steipete/example/archive/refs/tags/v1.0.1.tar.gz",
                "cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc",
                "1.0.1",
            )

        self.assertIn("multiple architecture-specific checksums", str(raised.exception))

    def test_duplicate_urls_in_platform_stanzas_use_stanza_mode(self) -> None:
        text = '''class Wacli < Formula
  on_macos do
    on_arm do
      url "https://github.com/openclaw/wacli/releases/download/v0.9.1/wacli-macos-universal.tar.gz"
      sha256 "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"
    end

    on_intel do
      url "https://github.com/openclaw/wacli/releases/download/v0.9.1/wacli-macos-universal.tar.gz"
      sha256 "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/openclaw/wacli/archive/refs/tags/v0.9.1.tar.gz"
      sha256 "bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb"
    end

    on_intel do
      url "https://github.com/openclaw/wacli/archive/refs/tags/v0.9.1.tar.gz"
      sha256 "bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb"
    end
  end

  def install
  end
end
'''

        self.assertTrue(update_formula.uses_stanza_url_mode(text, "0.9.2"))

    def test_converts_duplicate_platform_stanzas_to_target_urls(self) -> None:
        text = '''class Wacli < Formula
  version "0.9.2"

  on_macos do
    on_arm do
      url "https://github.com/openclaw/wacli/releases/download/v0.9.2/wacli-macos-universal.tar.gz"
      sha256 "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"
    end

    on_intel do
      url "https://github.com/openclaw/wacli/releases/download/v0.9.2/wacli-macos-universal.tar.gz"
      sha256 "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/openclaw/wacli/archive/refs/tags/v0.9.2.tar.gz"
      sha256 "bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb"
    end

    on_intel do
      url "https://github.com/openclaw/wacli/archive/refs/tags/v0.9.2.tar.gz"
      sha256 "bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb"
    end
  end

  def install
  end
end
'''

        updated = update_formula.convert_stanza_url_mode_to_targets(
            text,
            "openclaw/wacli",
            "v0.9.3",
            "wacli",
            "0.9.3",
            "{formula}_{version}_{target}.tar.gz",
            {},
        )

        self.assertIn("wacli_0.9.3_darwin_arm64.tar.gz", updated)
        self.assertIn("wacli_0.9.3_darwin_amd64.tar.gz", updated)
        self.assertIn("wacli_0.9.3_linux_arm64.tar.gz", updated)
        self.assertIn("wacli_0.9.3_linux_amd64.tar.gz", updated)
        self.assertNotIn("wacli-macos-universal.tar.gz", updated)
        self.assertNotIn("/archive/refs/tags/", updated)

    def test_inserts_target_stanzas_for_top_level_formula(self) -> None:
        text = '''class Sag < Formula
  desc "Command-line ElevenLabs TTS with mac-style flags"
  homepage "https://github.com/steipete/sag"
  url "https://github.com/steipete/sag/releases/download/v0.3.0/sag_0.3.0_darwin_universal.tar.gz"
  sha256 "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"
  license "MIT"

  on_linux do
    on_intel do
      url "https://github.com/steipete/sag/releases/download/v0.3.0/sag_0.3.0_linux_amd64.tar.gz"
      sha256 "bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb"
    end
  end

  def install
  end
end
'''

        updated = update_formula.insert_target_stanzas(
            text,
            "steipete/sag",
            "v0.3.1",
            "sag",
            "0.3.1",
            "{formula}_{version}_{target}.tar.gz",
            {},
        )

        self.assertIn("sag_0.3.1_darwin_arm64.tar.gz", updated)
        self.assertIn("sag_0.3.1_darwin_amd64.tar.gz", updated)
        self.assertIn("sag_0.3.1_linux_arm64.tar.gz", updated)
        self.assertIn("sag_0.3.1_linux_amd64.tar.gz", updated)
        self.assertNotIn("darwin_universal", updated)
        self.assertEqual(updated.count("on_linux do"), 1)

    def test_updates_cask_version_and_checksum_preserving_interpolated_url(self) -> None:
        text = '''cask "codexbar" do
  version "0.26.1"
  sha256 "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"

  url "https://github.com/steipete/CodexBar/releases/download/v#{version}/CodexBar-macos-universal-#{version}.zip",
      verified: "github.com/steipete/CodexBar/"
end
'''

        updated = update_formula.update_version(text, "0.27.0")
        updated = update_formula.update_top_level_url_and_sha(
            updated,
            "https://github.com/steipete/CodexBar/releases/download/v0.27.0/CodexBar-macos-universal-0.27.0.zip",
            "bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb",
            "0.27.0",
        )

        self.assertIn('version "0.27.0"', updated)
        self.assertIn('sha256 "bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb"', updated)
        self.assertIn("CodexBar-macos-universal-#{version}.zip", updated)

    def test_arm64_macos_artifact_keeps_top_level_arch_restriction(self) -> None:
        text = '''class Sonoscli < Formula
  desc "Control Sonos speakers from the command-line"
  homepage "https://github.com/steipete/sonoscli"
  url "https://github.com/steipete/sonoscli/releases/download/v0.3.1/sonoscli_0.3.1_darwin_arm64.tar.gz"
  version "0.3.1"
  sha256 "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"
  license "MIT"

  depends_on arch: :arm64

  def install
    bin.install Dir["**/sonos"].first => "sonos"
  end
end
'''

        updated = self.run_main_in_temp_tap(
            text,
            "--formula",
            "sonoscli",
            "--tag",
            "v0.3.2",
            "--repository",
            "steipete/sonoscli",
            "--macos-artifact",
            "sonoscli_0.3.2_darwin_arm64.tar.gz",
        )

        self.assertIn("sonoscli_0.3.2_darwin_arm64.tar.gz", updated)
        self.assertIn('sha256 "' + "c" * 64 + '"', updated)
        self.assertIn("depends_on arch: :arm64", updated)

    def test_universal_macos_artifact_removes_top_level_arm64_restriction_idempotently(self) -> None:
        text = '''class Sonoscli < Formula
  desc "Control Sonos speakers from the command-line"
  homepage "https://github.com/steipete/sonoscli"
  url "https://github.com/steipete/sonoscli/releases/download/v0.3.1/sonoscli_0.3.1_darwin_arm64.tar.gz"
  version "0.3.1"
  sha256 "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"
  license "MIT"

  depends_on arch: :arm64

  def install
    bin.install Dir["**/sonos"].first => "sonos"
  end
end
'''

        updated = self.run_main_in_temp_tap(
            text,
            "--formula",
            "sonoscli",
            "--tag",
            "v0.3.2",
            "--repository",
            "steipete/sonoscli",
            "--macos-artifact",
            "sonoscli_0.3.2_macos-universal.tar.gz",
        )
        updated_again = update_formula.remove_top_level_arm64_dependency_for_universal_macos(
            updated,
            "https://github.com/steipete/sonoscli/releases/download/v0.3.2/sonoscli_0.3.2_macos-universal.tar.gz",
            {},
            "0.3.2",
        )

        self.assertIn("sonoscli_0.3.2_macos-universal.tar.gz", updated)
        self.assertIn('version "0.3.2"', updated)
        self.assertIn('sha256 "' + "c" * 64 + '"', updated)
        self.assertNotIn("depends_on arch: :arm64", updated)
        self.assertIn("depends_on :macos", updated)
        self.assertEqual(updated_again, updated)

    def test_universal_macos_artifact_leaves_other_arch_syntax_unchanged(self) -> None:
        text = '''class Sonoscli < Formula
  desc "Control Sonos speakers from the command-line"
  homepage "https://github.com/steipete/sonoscli"
  url "https://github.com/steipete/sonoscli/releases/download/v0.3.1/sonoscli_0.3.1_darwin_arm64.tar.gz"
  version "0.3.1"
  sha256 "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"
  license "MIT"

  depends_on arch: :x86_64
  depends_on "libusb"

  def install
    bin.install Dir["**/sonos"].first => "sonos"
  end
end
'''

        updated = self.run_main_in_temp_tap(
            text,
            "--formula",
            "sonoscli",
            "--tag",
            "v0.3.2",
            "--repository",
            "steipete/sonoscli",
            "--macos-artifact",
            "sonoscli_0.3.2_macos-universal.tar.gz",
        )

        self.assertIn("depends_on arch: :x86_64", updated)
        self.assertIn('depends_on "libusb"', updated)

    def test_universal_repo_name_does_not_remove_arm64_restriction(self) -> None:
        text = '''class Sonoscli < Formula
  desc "Control Sonos speakers from the command-line"
  homepage "https://github.com/steipete/macos-universal-tools"
  url "https://github.com/steipete/macos-universal-tools/releases/download/v0.3.1/sonoscli_0.3.1_darwin_arm64.tar.gz"
  version "0.3.1"
  sha256 "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"
  license "MIT"

  depends_on arch: :arm64

  def install
    bin.install Dir["**/sonos"].first => "sonos"
  end
end
'''

        updated = self.run_main_in_temp_tap(
            text,
            "--formula",
            "sonoscli",
            "--tag",
            "v0.3.2",
            "--repository",
            "steipete/macos-universal-tools",
            "--macos-artifact",
            "sonoscli_0.3.2_darwin_arm64.tar.gz",
        )

        self.assertIn("sonoscli_0.3.2_darwin_arm64.tar.gz", updated)
        self.assertIn("depends_on arch: :arm64", updated)

    def test_universal_artifact_prefix_does_not_remove_arm64_restriction(self) -> None:
        text = '''class Sonoscli < Formula
  desc "Control Sonos speakers from the command-line"
  homepage "https://github.com/steipete/sonoscli"
  url "https://github.com/steipete/sonoscli/releases/download/v0.3.1/macos-universal-tools_0.3.1_darwin_arm64.tar.gz"
  version "0.3.1"
  sha256 "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"
  license "MIT"

  depends_on arch: :arm64

  def install
    bin.install Dir["**/sonos"].first => "sonos"
  end
end
'''

        updated = self.run_main_in_temp_tap(
            text,
            "--formula",
            "sonoscli",
            "--tag",
            "v0.3.2",
            "--repository",
            "steipete/sonoscli",
            "--macos-artifact",
            "macos-universal-tools_0.3.2_darwin_arm64.tar.gz",
        )

        self.assertIn("macos-universal-tools_0.3.2_darwin_arm64.tar.gz", updated)
        self.assertIn("depends_on arch: :arm64", updated)

    def test_existing_macos_dependency_is_not_duplicated(self) -> None:
        text = '''class Sonoscli < Formula
  desc "Control Sonos speakers from the command-line"
  homepage "https://github.com/steipete/sonoscli"
  url "https://github.com/steipete/sonoscli/releases/download/v0.3.1/sonoscli_0.3.1_darwin_arm64.tar.gz"
  version "0.3.1"
  sha256 "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"
  license "MIT"

  depends_on :macos
  depends_on arch: :arm64

  def install
    bin.install Dir["**/sonos"].first => "sonos"
  end
end
'''

        updated = self.run_main_in_temp_tap(
            text,
            "--formula",
            "sonoscli",
            "--tag",
            "v0.3.2",
            "--repository",
            "steipete/sonoscli",
            "--macos-artifact",
            "sonoscli_0.3.2_macos-universal.tar.gz",
        )

        self.assertEqual(updated.count("depends_on :macos"), 1)
        self.assertNotIn("depends_on arch: :arm64", updated)

    def test_existing_versioned_macos_dependency_is_not_duplicated(self) -> None:
        text = '''class Sonoscli < Formula
  desc "Control Sonos speakers from the command-line"
  homepage "https://github.com/steipete/sonoscli"
  url "https://github.com/steipete/sonoscli/releases/download/v0.3.1/sonoscli_0.3.1_darwin_arm64.tar.gz"
  version "0.3.1"
  sha256 "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"
  license "MIT"

  depends_on macos: :sonoma
  depends_on arch: :arm64

  def install
    bin.install Dir["**/sonos"].first => "sonos"
  end
end
'''

        updated = self.run_main_in_temp_tap(
            text,
            "--formula",
            "sonoscli",
            "--tag",
            "v0.3.2",
            "--repository",
            "steipete/sonoscli",
            "--macos-artifact",
            "sonoscli_0.3.2_macos-universal.tar.gz",
        )

        self.assertIn("depends_on macos: :sonoma", updated)
        self.assertNotIn("depends_on :macos", updated)
        self.assertNotIn("depends_on arch: :arm64", updated)

    def test_nested_macos_dependency_does_not_count_as_top_level(self) -> None:
        text = '''class Sonoscli < Formula
  desc "Control Sonos speakers from the command-line"
  homepage "https://github.com/steipete/sonoscli"
  url "https://github.com/steipete/sonoscli/releases/download/v0.3.1/sonoscli_0.3.1_darwin_arm64.tar.gz"
  version "0.3.1"
  sha256 "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"
  license "MIT"

  depends_on arch: :arm64

  on_arm do
    depends_on macos: :sonoma
  end

  def install
    bin.install Dir["**/sonos"].first => "sonos"
  end
end
'''

        updated = self.run_main_in_temp_tap(
            text,
            "--formula",
            "sonoscli",
            "--tag",
            "v0.3.2",
            "--repository",
            "steipete/sonoscli",
            "--macos-artifact",
            "sonoscli_0.3.2_macos-universal.tar.gz",
        )

        self.assertIn("  depends_on :macos", updated)
        self.assertIn("    depends_on macos: :sonoma", updated)
        self.assertNotIn("depends_on arch: :arm64", updated)

    def test_universal_target_alias_removes_arm64_restriction(self) -> None:
        text = '''class Sonoscli < Formula
  desc "Control Sonos speakers from the command-line"
  homepage "https://github.com/steipete/sonoscli"
  url "https://github.com/steipete/sonoscli/releases/download/v0.3.1/sonoscli_0.3.1_darwin_arm64.tar.gz"
  version "0.3.1"
  sha256 "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"
  license "MIT"

  depends_on arch: :arm64

  def install
    bin.install Dir["**/sonos"].first => "sonos"
  end
end
'''

        updated = self.run_main_in_temp_tap(
            text,
            "--formula",
            "sonoscli",
            "--tag",
            "v0.3.2",
            "--repository",
            "steipete/sonoscli",
            "--macos-artifact",
            "sonoscli_0.3.2_fat.tar.gz",
            "--target-aliases",
            "darwin_universal=fat",
        )

        self.assertIn("sonoscli_0.3.2_fat.tar.gz", updated)
        self.assertNotIn("depends_on arch: :arm64", updated)
        self.assertIn("depends_on :macos", updated)

    def test_universal_artifact_with_unlisted_archive_extension_removes_arm64_restriction(self) -> None:
        text = '''class Sonoscli < Formula
  desc "Control Sonos speakers from the command-line"
  homepage "https://github.com/steipete/sonoscli"
  url "https://github.com/steipete/sonoscli/releases/download/v0.3.1/sonoscli_0.3.1_darwin_arm64.tar.gz"
  version "0.3.1"
  sha256 "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"
  license "MIT"

  depends_on arch: :arm64

  def install
    bin.install Dir["**/sonos"].first => "sonos"
  end
end
'''

        updated = self.run_main_in_temp_tap(
            text,
            "--formula",
            "sonoscli",
            "--tag",
            "v0.3.2",
            "--repository",
            "steipete/sonoscli",
            "--macos-artifact",
            "sonoscli_0.3.2_darwin_universal.tar.zst",
        )

        self.assertIn("sonoscli_0.3.2_darwin_universal.tar.zst", updated)
        self.assertNotIn("depends_on arch: :arm64", updated)
        self.assertIn("depends_on :macos", updated)


if __name__ == "__main__":
    unittest.main()
