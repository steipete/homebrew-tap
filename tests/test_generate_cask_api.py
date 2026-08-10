from __future__ import annotations

import hashlib
import importlib.util
import json
import pathlib
import tempfile
import unittest
from unittest import mock


ROOT = pathlib.Path(__file__).resolve().parents[1]
SCRIPT = ROOT / ".github" / "scripts" / "generate_cask_api.py"
SPEC = importlib.util.spec_from_file_location("generate_cask_api", SCRIPT)
assert SPEC and SPEC.loader
generate_cask_api = importlib.util.module_from_spec(SPEC)
SPEC.loader.exec_module(generate_cask_api)


class GenerateCaskApiTest(unittest.TestCase):
    def metadata(self, tap: str, token: str, cask_path: pathlib.Path, head: str) -> dict[str, object]:
        return {
            "token": token,
            "full_token": f"{tap}/{token}",
            "tap": tap,
            "version": "1.2.3",
            "url": f"https://example.test/{token}.zip",
            "sha256": "a" * 64,
            "artifacts": [{"app": [f"{token}.app"]}],
            "tap_git_head": head,
            "ruby_source_path": f"Casks/{token}.rb",
            "ruby_source_checksum": {
                "sha256": hashlib.sha256(cask_path.read_bytes()).hexdigest(),
            },
        }

    def test_generates_every_cask_and_removes_stale_metadata(self) -> None:
        with tempfile.TemporaryDirectory() as directory:
            root = pathlib.Path(directory)
            casks_dir = root / "Casks"
            output_dir = root / "api" / "cask"
            casks_dir.mkdir()
            output_dir.mkdir(parents=True)
            for token in ("alpha", "beta"):
                (casks_dir / f"{token}.rb").write_text(f'cask "{token}" do\nend\n')
            stale_path = output_dir / "removed.json"
            stale_path.write_text("{}\n")

            head = "1" * 40

            def read_metadata(tap: str, token: str) -> dict[str, object]:
                return self.metadata(tap, token, casks_dir / f"{token}.rb", head)

            paths = generate_cask_api.generate(
                root=root,
                metadata_reader=read_metadata,
                source_head=head,
            )

            self.assertEqual([path.name for path in paths], ["alpha.json", "beta.json"])
            self.assertFalse(stale_path.exists())
            for token in ("alpha", "beta"):
                payload = json.loads((output_dir / f"{token}.json").read_text())
                self.assertEqual(payload["token"], token)
                self.assertEqual(payload["full_token"], f"steipete/tap/{token}")

    def test_rejects_metadata_from_a_stale_tap_checkout(self) -> None:
        with tempfile.TemporaryDirectory() as directory:
            root = pathlib.Path(directory)
            casks_dir = root / "Casks"
            casks_dir.mkdir()
            cask_path = casks_dir / "alpha.rb"
            cask_path.write_text('cask "alpha" do\nend\n')
            metadata = self.metadata("steipete/tap", "alpha", cask_path, "a" * 40)

            with self.assertRaisesRegex(SystemExit, "sync the tapped checkout"):
                generate_cask_api.generate(
                    root=root,
                    metadata_reader=lambda _tap, _token: metadata,
                    source_head="b" * 40,
                )

    def test_local_state_defaults_match_static_api_behavior(self) -> None:
        self.assertEqual(
            generate_cask_api.LOCAL_STATE_DEFAULTS,
            {
                "installed": None,
                "installed_time": None,
                "bundle_version": None,
                "bundle_short_version": None,
                "pinned": False,
                "pinned_version": None,
                "outdated": False,
            },
        )

    def test_brew_metadata_normalizes_machine_local_state(self) -> None:
        payload = self.metadata(
            "steipete/tap",
            "alpha",
            pathlib.Path(__file__),
            "1" * 40,
        )
        payload.update(
            {
                "installed": "1.2.3",
                "installed_time": 123,
                "bundle_version": "42",
                "bundle_short_version": "1.2.3",
                "pinned": True,
                "pinned_version": "1.2.3",
                "outdated": True,
            }
        )
        completed = mock.Mock(stdout=json.dumps({"casks": [payload]}))

        with mock.patch.object(generate_cask_api.subprocess, "run", return_value=completed) as run:
            metadata = generate_cask_api.brew_metadata("steipete/tap", "alpha")

        for field, expected in generate_cask_api.LOCAL_STATE_DEFAULTS.items():
            self.assertEqual(metadata[field], expected)
        command = run.call_args.args[0]
        self.assertEqual(command[-1], "steipete/tap/alpha")
        self.assertEqual(run.call_args.kwargs["env"]["HOMEBREW_NO_INSTALL_FROM_API"], "1")


if __name__ == "__main__":
    unittest.main()
