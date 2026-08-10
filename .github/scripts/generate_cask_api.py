#!/usr/bin/env python3
"""Generate raw Homebrew API metadata for every cask in this tap."""

from __future__ import annotations

import argparse
import hashlib
import json
import os
import pathlib
import re
import subprocess
import sys
from collections.abc import Callable
from typing import Any


ROOT = pathlib.Path(__file__).resolve().parents[2]
TOKEN_PATTERN = re.compile(r"[a-z0-9][a-z0-9+._@-]*")
LOCAL_STATE_DEFAULTS = {
    "installed": None,
    "installed_time": None,
    "bundle_version": None,
    "bundle_short_version": None,
    "pinned": False,
    "pinned_version": None,
    "outdated": False,
}


def git_head(root: pathlib.Path) -> str:
    result = subprocess.run(
        ["git", "rev-parse", "HEAD"],
        cwd=root,
        check=True,
        capture_output=True,
        text=True,
    )
    return result.stdout.strip()


def brew_metadata(tap: str, token: str) -> dict[str, Any]:
    env = os.environ.copy()
    env["HOMEBREW_NO_AUTO_UPDATE"] = "1"
    env["HOMEBREW_NO_INSTALL_FROM_API"] = "1"
    result = subprocess.run(
        [
            "brew",
            "info",
            "--json=v2",
            "--variations",
            "--cask",
            f"{tap}/{token}",
        ],
        check=True,
        capture_output=True,
        text=True,
        env=env,
    )
    try:
        payload = json.loads(result.stdout)
    except json.JSONDecodeError as error:
        raise SystemExit(f"brew returned invalid JSON for {token}: {error}") from error

    casks = payload.get("casks")
    if not isinstance(casks, list) or len(casks) != 1 or not isinstance(casks[0], dict):
        raise SystemExit(f"brew returned {len(casks) if isinstance(casks, list) else 0} casks for {token}")

    metadata = casks[0]
    for field, value in LOCAL_STATE_DEFAULTS.items():
        metadata[field] = value
    return metadata


def validate_metadata(
    metadata: dict[str, Any],
    *,
    tap: str,
    token: str,
    cask_path: pathlib.Path,
    root: pathlib.Path,
    source_head: str,
) -> None:
    expected_full_token = f"{tap}/{token}"
    expected_source_path = cask_path.relative_to(root).as_posix()
    expected_checksum = hashlib.sha256(cask_path.read_bytes()).hexdigest()
    checks = {
        "token": token,
        "full_token": expected_full_token,
        "tap": tap,
        "tap_git_head": source_head,
        "ruby_source_path": expected_source_path,
    }
    for field, expected in checks.items():
        if metadata.get(field) != expected:
            raise SystemExit(
                f"{token}: {field} is {metadata.get(field)!r}, expected {expected!r}; "
                "sync the tapped checkout to this commit before generating"
            )

    required_values = {
        "version": metadata.get("version"),
        "url": metadata.get("url"),
        "sha256": metadata.get("sha256"),
    }
    for field, value in required_values.items():
        if not isinstance(value, str) or not value:
            raise SystemExit(f"{token}: brew metadata has no usable {field}")
    artifacts = metadata.get("artifacts")
    if not isinstance(artifacts, list) or not artifacts:
        raise SystemExit(f"{token}: brew metadata has no artifacts")

    checksum = metadata.get("ruby_source_checksum")
    if not isinstance(checksum, dict) or checksum.get("sha256") != expected_checksum:
        raise SystemExit(
            f"{token}: ruby_source_checksum does not match {expected_source_path}; "
            "sync the tapped checkout to this commit before generating"
        )


def generate(
    *,
    root: pathlib.Path = ROOT,
    tap: str = "steipete/tap",
    metadata_reader: Callable[[str, str], dict[str, Any]] = brew_metadata,
    source_head: str | None = None,
) -> list[pathlib.Path]:
    casks_dir = root / "Casks"
    output_dir = root / "api" / "cask"
    cask_paths = sorted(casks_dir.glob("*.rb"))
    if not cask_paths:
        raise SystemExit(f"no casks found in {casks_dir}")

    head = source_head or git_head(root)
    generated: dict[pathlib.Path, str] = {}
    for cask_path in cask_paths:
        token = cask_path.stem
        if not TOKEN_PATTERN.fullmatch(token):
            raise SystemExit(f"unsupported cask token derived from {cask_path.name}: {token!r}")
        metadata = metadata_reader(tap, token)
        validate_metadata(
            metadata,
            tap=tap,
            token=token,
            cask_path=cask_path,
            root=root,
            source_head=head,
        )
        generated[output_dir / f"{token}.json"] = json.dumps(
            metadata,
            indent=2,
            sort_keys=True,
        ) + "\n"

    output_dir.mkdir(parents=True, exist_ok=True)
    expected_paths = set(generated)
    for stale_path in output_dir.glob("*.json"):
        if stale_path not in expected_paths:
            stale_path.unlink()
            print(f"removed stale {stale_path.relative_to(root)}")

    for output_path, content in generated.items():
        output_path.write_text(content)
        print(f"generated {output_path.relative_to(root)}")
    return sorted(expected_paths)


def main() -> None:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--tap", default="steipete/tap", help="fully qualified tap name")
    args = parser.parse_args()
    try:
        generate(tap=args.tap)
    except subprocess.CalledProcessError as error:
        if error.stderr:
            print(error.stderr.rstrip(), file=sys.stderr)
        raise SystemExit(f"command failed with exit code {error.returncode}: {' '.join(error.cmd)}") from error


if __name__ == "__main__":
    main()
