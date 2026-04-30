#!/usr/bin/env python3
"""Update a Homebrew formula for a GitHub release.

The script keeps formula-specific editing in this tap. It supports the simple
single `url`/`sha256` formula shape as well as formulae with separate
`on_macos` and `on_linux` stanzas such as `Formula/wacli.rb`.
"""

from __future__ import annotations

import argparse
import hashlib
import os
import pathlib
import re
import sys
import urllib.request


USER_AGENT = "steipete-homebrew-tap-updater"


def sha256(url: str) -> str:
    headers = {"User-Agent": USER_AGENT}
    token = os.environ.get("GITHUB_TOKEN")
    if token and url.startswith("https://github.com/"):
        headers["Authorization"] = f"Bearer {token}"

    request = urllib.request.Request(url, headers=headers)
    digest = hashlib.sha256()
    with urllib.request.urlopen(request) as response:
        while chunk := response.read(1024 * 1024):
            digest.update(chunk)
    return digest.hexdigest()


def replace_once(text: str, pattern: str, replacement: str, description: str) -> str:
    matches = re.findall(pattern, text, flags=re.MULTILINE | re.DOTALL)
    if len(matches) != 1:
        raise SystemExit(f"expected exactly one {description}, found {len(matches)}")
    return re.sub(pattern, replacement, text, count=1, flags=re.MULTILINE | re.DOTALL)


def replace_zero_or_one(text: str, pattern: str, replacement: str, description: str) -> str:
    matches = re.findall(pattern, text, flags=re.MULTILINE | re.DOTALL)
    if len(matches) > 1:
        raise SystemExit(f"expected at most one {description}, found {len(matches)}")
    if not matches:
        print(f"no explicit {description}; leaving it unchanged")
        return text
    return re.sub(pattern, replacement, text, count=1, flags=re.MULTILINE | re.DOTALL)


def stanza_body(text: str, stanza: str) -> str | None:
    match = re.search(
        rf'^\s*{stanza}\s+do\s*$\n(?P<body>.*?)(?=^\s*(?:on_macos\s+do|on_linux\s+do|head |def |test do))',
        text,
        flags=re.MULTILINE | re.DOTALL,
    )
    if not match:
        return None
    return match.group("body")


def require_single_sha_in_stanza(text: str, stanza: str) -> None:
    body = stanza_body(text, stanza)
    if body is None:
        return

    checksums = re.findall(r'^\s*sha256\s+"[^"]+"', body, flags=re.MULTILINE)
    if len(checksums) != 1:
        raise SystemExit(
            f"expected exactly one sha256 in {stanza} stanza, found {len(checksums)}; "
            "formulae with multiple architecture-specific checksums need manual updates"
        )


def update_sha_in_stanza(text: str, stanza: str, digest: str) -> str:
    require_single_sha_in_stanza(text, stanza)
    return replace_once(
        text,
        rf'(\n\s*{stanza}\s+do\n(?:.*?\n)*?\s+sha256\s+")[^"]+(")',
        rf'\g<1>{digest}\2',
        f"sha256 in {stanza} stanza",
    )


def has_stanza(text: str, stanza: str) -> bool:
    return stanza_body(text, stanza) is not None


def update_top_level_url_and_sha(text: str, url: str, digest: str) -> str:
    text = replace_once(
        text,
        r'^(\s*url\s+")[^"]+(")',
        rf'\g<1>{url}\2',
        "top-level url",
    )
    return replace_once(
        text,
        r'^(\s*sha256\s+")[^"]+(")',
        rf'\g<1>{digest}\2',
        "top-level sha256",
    )


def main() -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--formula", required=True, help="Formula name, e.g. wacli")
    parser.add_argument("--tag", required=True, help="Release tag, e.g. v0.7.0")
    parser.add_argument("--repository", required=True, help="Source repository, e.g. steipete/wacli")
    parser.add_argument(
        "--macos-artifact",
        help="macOS release artifact name. Defaults to <formula>-macos-universal.tar.gz",
    )
    parser.add_argument(
        "--linux-url",
        help="Linux source/archive URL. Defaults to the GitHub tag archive",
    )
    args = parser.parse_args()

    version = args.tag[1:] if args.tag.startswith("v") else args.tag
    macos_artifact = args.macos_artifact or f"{args.formula}-macos-universal.tar.gz"
    macos_url = f"https://github.com/{args.repository}/releases/download/{args.tag}/{macos_artifact}"
    linux_url = args.linux_url or f"https://github.com/{args.repository}/archive/refs/tags/{args.tag}.tar.gz"

    path = pathlib.Path("Formula") / f"{args.formula}.rb"
    text = path.read_text()
    require_single_sha_in_stanza(text, "on_macos")
    require_single_sha_in_stanza(text, "on_linux")

    macos_sha = sha256(macos_url)
    text = replace_zero_or_one(
        text,
        r'^(\s*version\s+")[^"]+(")',
        rf'\g<1>{version}\2',
        "version",
    )

    if has_stanza(text, "on_macos"):
        text = update_sha_in_stanza(text, "on_macos", macos_sha)
    else:
        text = update_top_level_url_and_sha(text, macos_url, macos_sha)

    if has_stanza(text, "on_linux"):
        linux_sha = sha256(linux_url)
        text = update_sha_in_stanza(text, "on_linux", linux_sha)
    else:
        linux_sha = None

    path.write_text(text)

    print(f"updated {path} to {version}")
    print(f"macOS: {macos_sha}  {macos_url}")
    if linux_sha:
        print(f"Linux: {linux_sha}  {linux_url}")
    return 0


if __name__ == "__main__":
    sys.exit(main())
