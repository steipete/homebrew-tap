from __future__ import annotations

import importlib.util
import pathlib
import unittest


ROOT = pathlib.Path(__file__).resolve().parents[1]
SCRIPT = ROOT / ".github" / "scripts" / "update_formula.py"
SPEC = importlib.util.spec_from_file_location("update_formula", SCRIPT)
assert SPEC and SPEC.loader
update_formula = importlib.util.module_from_spec(SPEC)
SPEC.loader.exec_module(update_formula)


class UpdateFormulaTest(unittest.TestCase):
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

    def test_converts_platform_stanzas_to_architecture_artifacts(self) -> None:
        text = '''class Wacli < Formula
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

        def digest(url: str) -> str:
            return {
                "https://github.com/steipete/wacli/releases/download/v0.9.3/wacli-darwin-arm64.tar.gz": "1" * 64,
                "https://github.com/steipete/wacli/releases/download/v0.9.3/wacli-darwin-amd64.tar.gz": "2" * 64,
                "https://github.com/steipete/wacli/releases/download/v0.9.3/wacli-linux-arm64.tar.gz": "3" * 64,
                "https://github.com/steipete/wacli/releases/download/v0.9.3/wacli-linux-amd64.tar.gz": "4" * 64,
            }[url]

        updated, targets = update_formula.update_url_and_sha_by_target_blocks(
            text,
            "steipete/wacli",
            "v0.9.3",
            "wacli",
            "0.9.3",
            "wacli-{target}.tar.gz",
            {
                "darwin_amd64": "darwin-amd64",
                "darwin_arm64": "darwin-arm64",
                "linux_amd64": "linux-amd64",
                "linux_arm64": "linux-arm64",
            },
            digest,
        )

        self.assertEqual(targets, {"darwin_arm64", "darwin_amd64", "linux_arm64", "linux_amd64"})
        self.assertIn("wacli-darwin-arm64.tar.gz", updated)
        self.assertIn("wacli-darwin-amd64.tar.gz", updated)
        self.assertIn("wacli-linux-arm64.tar.gz", updated)
        self.assertIn("wacli-linux-amd64.tar.gz", updated)
        self.assertNotIn("wacli-macos-universal.tar.gz", updated)
        self.assertNotIn("archive/refs/tags", updated)

    def test_updates_existing_architecture_artifact_urls(self) -> None:
        text = '''class Wacli < Formula
  on_macos do
    on_arm do
      url "https://github.com/steipete/wacli/releases/download/v0.9.2/wacli-darwin-arm64.tar.gz"
      sha256 "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"
    end

    on_intel do
      url "https://github.com/steipete/wacli/releases/download/v0.9.2/wacli-darwin-amd64.tar.gz"
      sha256 "bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/steipete/wacli/releases/download/v0.9.2/wacli-linux-arm64.tar.gz"
      sha256 "cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc"
    end

    on_intel do
      url "https://github.com/steipete/wacli/releases/download/v0.9.2/wacli-linux-amd64.tar.gz"
      sha256 "dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd"
    end
  end

  def install
  end
end
'''

        aliases = {
            "darwin_amd64": "darwin-amd64",
            "darwin_arm64": "darwin-arm64",
            "linux_amd64": "linux-amd64",
            "linux_arm64": "linux-arm64",
        }

        def digest(url: str) -> str:
            return {
                "https://github.com/steipete/wacli/releases/download/v0.9.3/wacli-darwin-arm64.tar.gz": "1" * 64,
                "https://github.com/steipete/wacli/releases/download/v0.9.3/wacli-darwin-amd64.tar.gz": "2" * 64,
                "https://github.com/steipete/wacli/releases/download/v0.9.3/wacli-linux-arm64.tar.gz": "3" * 64,
                "https://github.com/steipete/wacli/releases/download/v0.9.3/wacli-linux-amd64.tar.gz": "4" * 64,
            }[url]

        pairs = update_formula.iter_url_sha_pairs(text)
        classified = [(match, update_formula.classify_target(match.group("url"), aliases, "0.9.3")) for match in pairs]

        updated, targets = update_formula.update_url_and_sha_by_classified_targets(
            text,
            classified,
            "steipete/wacli",
            "v0.9.3",
            "wacli",
            "0.9.3",
            "wacli-{target}.tar.gz",
            aliases,
            len(classified),
            pathlib.Path("Formula/wacli.rb"),
            digest,
        )

        self.assertEqual(targets, {"darwin_arm64", "darwin_amd64", "linux_arm64", "linux_amd64"})
        self.assertNotIn("v0.9.2", updated)
        self.assertIn("wacli-darwin-arm64.tar.gz", updated)
        self.assertIn("wacli-darwin-amd64.tar.gz", updated)
        self.assertIn("wacli-linux-arm64.tar.gz", updated)
        self.assertIn("wacli-linux-amd64.tar.gz", updated)
        self.assertIn('sha256 "' + "1" * 64 + '"', updated)
        self.assertIn('sha256 "' + "2" * 64 + '"', updated)
        self.assertIn('sha256 "' + "3" * 64 + '"', updated)
        self.assertIn('sha256 "' + "4" * 64 + '"', updated)

    def test_rejects_missing_target_when_existing_architecture_urls_are_expected(self) -> None:
        text = '''class Wacli < Formula
  on_macos do
    on_arm do
      url "https://github.com/steipete/wacli/releases/download/v0.9.2/wacli-darwin-arm64.tar.gz"
      sha256 "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"
    end

    on_intel do
      url "https://github.com/steipete/wacli/releases/download/v0.9.2/wacli-darwin-amd64.tar.gz"
      sha256 "bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/steipete/wacli/releases/download/v0.9.2/wacli-linux-arm64.tar.gz"
      sha256 "cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc"
    end

    on_intel do
      url "https://github.com/steipete/wacli/releases/download/v0.9.2/wacli-linux-arm64.tar.gz"
      sha256 "dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd"
    end
  end

  def install
  end
end
'''

        aliases = {
            "darwin_amd64": "darwin-amd64",
            "darwin_arm64": "darwin-arm64",
            "linux_amd64": "linux-amd64",
            "linux_arm64": "linux-arm64",
        }
        pairs = update_formula.iter_url_sha_pairs(text)
        classified = [(match, update_formula.classify_target(match.group("url"), aliases, "0.9.3")) for match in pairs]

        with self.assertRaises(SystemExit) as raised:
            update_formula.update_url_and_sha_by_classified_targets(
                text,
                classified,
                "steipete/wacli",
                "v0.9.3",
                "wacli",
                "0.9.3",
                "wacli-{target}.tar.gz",
                aliases,
                len(classified),
                pathlib.Path("Formula/wacli.rb"),
                lambda _url: "1" * 64,
            )

        self.assertIn("failed to update linux_amd64", str(raised.exception))

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


if __name__ == "__main__":
    unittest.main()
