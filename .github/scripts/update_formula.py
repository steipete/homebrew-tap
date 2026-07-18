#!/usr/bin/env python3
"""Update a Homebrew formula and optional cask for a GitHub release.

The script keeps formula-specific editing in this tap. It supports the simple
single `url`/`sha256` formula shape as well as formulae with separate
`on_macos` and `on_linux` stanzas such as `Formula/wacli.rb`. It can also
update a matching cask when a release publishes both CLI and app assets.
"""

from __future__ import annotations

import argparse
import hashlib
import json
import os
import pathlib
import re
import sys
import time
import urllib.error
import urllib.parse
import urllib.request


USER_AGENT = "steipete-homebrew-tap-updater"
RELEASE_ASSET_ATTEMPTS = 6
RELEASE_ASSET_INITIAL_BACKOFF = 10.0
RELEASE_TARGETS = ("darwin_amd64", "darwin_arm64", "linux_amd64", "linux_arm64")
ARTIFACT_NAME_PATTERN = re.compile(r"[A-Za-z0-9][A-Za-z0-9+@._-]*")
SHA256_PATTERN = re.compile(r"[0-9a-f]{64}")


def parse_explicit_assets(value: str | None) -> dict[str, dict[str, str]] | None:
    if not value:
        return None
    try:
        payload = json.loads(value)
    except json.JSONDecodeError as error:
        raise SystemExit(f"invalid assets JSON: {error.msg}") from error
    if not isinstance(payload, dict) or set(payload) != set(RELEASE_TARGETS):
        raise SystemExit("assets JSON must contain exactly darwin_amd64, darwin_arm64, linux_amd64, and linux_arm64")

    assets: dict[str, dict[str, str]] = {}
    names: set[str] = set()
    for target in RELEASE_TARGETS:
        item = payload[target]
        if not isinstance(item, dict) or set(item) != {"name", "sha256"}:
            raise SystemExit(f"assets JSON {target} must contain exactly name and sha256")
        name = item["name"]
        digest = item["sha256"]
        if not isinstance(name, str) or not ARTIFACT_NAME_PATTERN.fullmatch(name) or not name.endswith(".tar.gz"):
            raise SystemExit(f"assets JSON {target} has an unsafe release asset filename")
        if not isinstance(digest, str) or not SHA256_PATTERN.fullmatch(digest):
            raise SystemExit(f"assets JSON {target} has an invalid SHA-256")
        if name in names:
            raise SystemExit(f"assets JSON repeats release asset filename {name!r}")
        names.add(name)
        assets[target] = {"name": name, "sha256": digest}
    return assets


def explicit_asset_url(repository: str, tag: str, name: str) -> str:
    return f"https://github.com/{repository}/releases/download/{tag}/{name}"


def verify_explicit_assets(repository: str, tag: str, assets: dict[str, dict[str, str]]) -> None:
    for target in RELEASE_TARGETS:
        item = assets[target]
        url = explicit_asset_url(repository, tag, item["name"])
        observed = sha256(url)
        if observed != item["sha256"]:
            raise SystemExit(
                f"downloaded {target} SHA-256 mismatch: observed {observed}, expected {item['sha256']}"
            )
        print(f"verified {target}: {observed}  {url}")


def sha256(
    url: str,
    *,
    attempts: int = RELEASE_ASSET_ATTEMPTS,
    initial_backoff: float = RELEASE_ASSET_INITIAL_BACKOFF,
) -> str:
    headers = {"User-Agent": USER_AGENT}
    token = os.environ.get("GITHUB_TOKEN")
    if token and url.startswith("https://github.com/"):
        headers["Authorization"] = f"Bearer {token}"

    request = urllib.request.Request(url, headers=headers)
    for attempt in range(1, attempts + 1):
        try:
            digest = hashlib.sha256()
            with urllib.request.urlopen(request) as response:
                while chunk := response.read(1024 * 1024):
                    digest.update(chunk)
            return digest.hexdigest()
        except urllib.error.HTTPError as error:
            is_missing_release_asset = error.code == 404 and "/releases/download/" in url
            if not is_missing_release_asset or attempt == attempts:
                raise

            error.close()
            delay = initial_backoff * (2 ** (attempt - 1))
            print(
                f"release asset unavailable (404); retrying in {delay:g}s "
                f"({attempt}/{attempts}): {url}",
                file=sys.stderr,
            )
            time.sleep(delay)

    raise AssertionError("unreachable")


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


def format_template(value: str, formula: str, version: str, tag: str, target: str | None = None) -> str:
    replacements = {
        "formula": formula,
        "version": version,
        "tag": tag,
    }
    if target is not None:
        replacements["target"] = target
    return value.format(**replacements)


def parse_target_aliases(value: str | None) -> dict[str, str]:
    if not value:
        return {}

    aliases: dict[str, str] = {}
    for item in value.split(","):
        if not item:
            continue
        if "=" not in item:
            raise SystemExit(f"invalid target alias {item!r}; expected canonical=artifact-target")
        canonical, artifact_target = item.split("=", 1)
        aliases[canonical.strip()] = artifact_target.strip()
    return aliases


def target_markers(target: str, alias: str | None = None) -> tuple[str, ...]:
    markers = {target, target.replace("_", "-")}
    if target == "darwin_amd64":
        markers.update(("macos-x86_64", "macos-amd64", "darwin-x86_64"))
    elif target == "darwin_arm64":
        markers.update(("macos-arm64", "darwin-aarch64"))
    elif target == "linux_amd64":
        markers.update(("linux-x86_64", "linux-amd64"))
    elif target == "linux_arm64":
        markers.update(("linux-aarch64", "linux-arm64"))
    elif target == "darwin_universal":
        markers.update(("macos-universal", "darwin-universal"))
    if alias:
        markers.add(alias)
    return tuple(sorted(markers, key=len, reverse=True))


def classify_target(url: str, aliases: dict[str, str], version: str) -> str | None:
    expanded = url.replace("#{version}", version)
    for target in ("darwin_universal", "darwin_arm64", "darwin_amd64", "linux_arm64", "linux_amd64"):
        for marker in target_markers(target, aliases.get(target)):
            if marker in expanded:
                return target
    return None


def iter_url_sha_pairs(text: str) -> list[re.Match[str]]:
    return list(
        re.finditer(
            r'(?P<prefix>url ")(?P<url>[^"]+)(?P<middle>"\n\s+sha256 ")(?P<sha>[0-9a-f]+)(?P<suffix>")',
            text,
            flags=re.MULTILINE,
        )
    )


def stanza_body(text: str, stanza: str) -> str | None:
    match = re.search(
        rf'^\s*{stanza}\s+do\s*$\n(?P<body>.*?)(?=^\s*(?:on_macos\s+do|on_linux\s+do|resource\s+|head |def |test do))',
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


def stanza_url_shape_count(text: str, stanza: str, version: str) -> int:
    body = stanza_body(text, stanza)
    if body is None:
        return 0

    pairs = iter_url_sha_pairs(body)
    return len({pair.group("url").replace("#{version}", version) for pair in pairs})


def uses_stanza_url_mode(text: str, version: str) -> bool:
    if not (has_stanza(text, "on_macos") and has_stanza(text, "on_linux")):
        return False
    return all(stanza_url_shape_count(text, stanza, version) <= 1 for stanza in ("on_macos", "on_linux"))


def stanza_match(text: str, stanza: str) -> re.Match[str] | None:
    return re.search(
        rf'(?P<header>^\s*{stanza}\s+do\s*$\n)(?P<body>.*?)(?=^\s*(?:on_macos\s+do|on_linux\s+do|resource\s+|head |def |test do))',
        text,
        flags=re.MULTILINE | re.DOTALL,
    )


def replace_url_preserving_interpolation(
    text: str,
    pattern: str,
    url: str,
    version: str,
    description: str,
) -> str:
    matches = list(re.finditer(pattern, text, flags=re.MULTILINE | re.DOTALL))
    if len(matches) != 1:
        raise SystemExit(f"expected exactly one {description}, found {len(matches)}")

    match = matches[0]
    existing_url = match.group("url")
    if "#{version}" in existing_url and existing_url.replace("#{version}", version) == url:
        print(f"{description} uses #{{version}} interpolation; leaving it unchanged")
        return text

    return text[: match.start("url")] + url + text[match.end("url") :]


def update_url_and_sha_in_stanza(text: str, stanza: str, url: str, digest: str, version: str) -> str:
    match = stanza_match(text, stanza)
    if not match:
        return text

    body = match.group("body")
    pairs = iter_url_sha_pairs(body)
    if not pairs:
        raise SystemExit(f"expected at least one url/sha256 pair in {stanza} stanza")

    expanded_urls = {pair.group("url").replace("#{version}", version) for pair in pairs}
    if len(expanded_urls) > 1:
        raise SystemExit(
            f"expected one source URL shape in {stanza} stanza, found {len(expanded_urls)}; "
            "formulae with multiple architecture-specific checksums need manual updates"
        )

    replacements: list[tuple[int, int, str]] = []
    for pair in pairs:
        existing_url = pair.group("url")
        replacement_url = url
        if "#{version}" in existing_url and existing_url.replace("#{version}", version) == url:
            replacement_url = existing_url
        replacements.append(
            (
                pair.start(),
                pair.end(),
                f'{pair.group("prefix")}{replacement_url}{pair.group("middle")}{digest}{pair.group("suffix")}',
            )
        )

    for start, end, replacement in reversed(replacements):
        body = body[:start] + replacement + body[end:]

    return text[: match.start("body")] + body + text[match.end("body") :]


def has_stanza(text: str, stanza: str) -> bool:
    return stanza_body(text, stanza) is not None


def predicate_architecture(line: str) -> str | None:
    match = re.fullmatch(
        r"    (?:if|elsif) Hardware::CPU\.(arm|intel)\?(?: && Hardware::CPU\.is_64_bit\?)?\n?",
        line,
    )
    if match:
        return "arm64" if match.group(1) == "arm" else "amd64"
    match = re.fullmatch(r"    on_(arm|intel) do\n?", line)
    if match:
        return "arm64" if match.group(1) == "arm" else "amd64"
    return None


def update_explicit_stanza(
    text: str,
    stanza: str,
    repository: str,
    tag: str,
    assets: dict[str, dict[str, str]],
) -> str:
    matches = list(re.finditer(rf"^  {stanza} do$", text, flags=re.MULTILINE))
    match = stanza_match(text, stanza)
    if len(matches) != 1 or match is None:
        raise SystemExit(f"explicit-assets mode requires exactly one {stanza} stanza")

    prefix = "darwin" if stanza == "on_macos" else "linux"
    lines = match.group("body").splitlines(keepends=True)
    current_architecture: str | None = None
    conditional_architecture: str | None = None
    seen_targets: set[str] = set()
    index = 0
    while index < len(lines):
        architecture = predicate_architecture(lines[index])
        if architecture:
            current_architecture = architecture
            conditional_architecture = architecture
            index += 1
            continue
        if re.fullmatch(r"    else\n?", lines[index]):
            if conditional_architecture is None:
                raise SystemExit(f"explicit-assets mode found an unmatched else in {stanza}")
            current_architecture = "amd64" if conditional_architecture == "arm64" else "arm64"
            index += 1
            continue
        if re.fullmatch(r"    end\n?", lines[index]):
            current_architecture = None
            conditional_architecture = None
            index += 1
            continue

        url_match = re.fullmatch(r'(\s+)url "[^"]+"\n?', lines[index])
        if not url_match:
            index += 1
            continue
        if current_architecture is None or index + 1 >= len(lines):
            raise SystemExit(f"explicit-assets mode could not bind a {stanza} URL to an architecture predicate")
        sha_match = re.fullmatch(r'(\s+)sha256 "[0-9a-f]+"\n?', lines[index + 1])
        if not sha_match or sha_match.group(1) != url_match.group(1):
            raise SystemExit(f"explicit-assets mode requires adjacent URL/checksum pairs in {stanza}")

        target = f"{prefix}_{current_architecture}"
        if target in seen_targets:
            raise SystemExit(f"explicit-assets mode found duplicate {target} URL/checksum pairs")
        item = assets[target]
        newline = "\n" if lines[index].endswith("\n") else ""
        indentation = url_match.group(1)
        lines[index] = f'{indentation}url "{explicit_asset_url(repository, tag, item["name"])}"{newline}'
        lines[index + 1] = f'{indentation}sha256 "{item["sha256"]}"{newline}'
        seen_targets.add(target)
        index += 2

    expected_targets = {f"{prefix}_arm64", f"{prefix}_amd64"}
    if seen_targets != expected_targets:
        raise SystemExit(f"explicit-assets mode requires exact arm64 and amd64 pairs in {stanza}")
    body = "".join(lines)
    return text[: match.start("body")] + body + text[match.end("body") :]


def render_explicit_target_formula(
    text: str,
    repository: str,
    tag: str,
    version: str,
    assets: dict[str, dict[str, str]],
) -> str:
    text = update_repository_metadata(text, repository)
    text = update_version(text, version)
    text = update_explicit_stanza(text, "on_macos", repository, tag, assets)
    text = update_explicit_stanza(text, "on_linux", repository, tag, assets)
    actual_pairs = sorted(
        (match.group("url").replace("#{version}", version), match.group("sha"))
        for stanza in ("on_macos", "on_linux")
        for match in iter_url_sha_pairs(stanza_body(text, stanza) or "")
    )
    expected_pairs = sorted(
        (explicit_asset_url(repository, tag, assets[target]["name"]), assets[target]["sha256"])
        for target in RELEASE_TARGETS
    )
    if actual_pairs != expected_pairs:
        raise SystemExit("explicit-assets rendering did not produce the exact target URL/checksum inventory")
    return text


def ruby_class_name(formula: str) -> str:
    return "".join(part.capitalize() for part in re.split(r"[-_]+", formula) if part)


def seed_formula(formula: str, repository: str, version: str, description: str, template: str) -> str:
    def url(target: str) -> str:
        artifact = template.format(
            formula=formula,
            version="#{version}",
            tag=f"v{version}",
            target=target,
        )
        return f"https://github.com/{repository}/releases/download/v#{{version}}/{artifact}"

    class_name = ruby_class_name(formula)
    return f'''class {class_name} < Formula
  desc "{description}"
  homepage "https://github.com/{repository}"
  version "{version}"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "{url("darwin_arm64")}"
      sha256 "0000000000000000000000000000000000000000000000000000000000000000"
    else
      url "{url("darwin_amd64")}"
      sha256 "0000000000000000000000000000000000000000000000000000000000000000"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "{url("linux_arm64")}"
      sha256 "0000000000000000000000000000000000000000000000000000000000000000"
    else
      url "{url("linux_amd64")}"
      sha256 "0000000000000000000000000000000000000000000000000000000000000000"
    end
  end

  def install
    bin.install "{formula}"
  end

  test do
    assert_match version.to_s, shell_output("#{{bin}}/{formula} --version")
  end
end
'''


def target_url(
    repository: str,
    tag: str,
    formula: str,
    version: str,
    template: str,
    target_aliases: dict[str, str],
    target: str,
) -> str:
    artifact_target = target_aliases.get(target, target)
    artifact = template.format(
        formula=formula,
        version=version,
        tag=tag,
        target=artifact_target,
    )
    return f"https://github.com/{repository}/releases/download/{tag}/{artifact}"


def target_stanza(
    stanza: str,
    first_target: str,
    second_target: str,
    repository: str,
    tag: str,
    formula: str,
    version: str,
    template: str,
    target_aliases: dict[str, str],
) -> str:
    first_url = target_url(repository, tag, formula, version, template, target_aliases, first_target)
    second_url = target_url(repository, tag, formula, version, template, target_aliases, second_target)
    first_predicate = "Hardware::CPU.arm?" if first_target.endswith("arm64") else "Hardware::CPU.intel?"
    second_predicate = "Hardware::CPU.intel?" if second_target.endswith("amd64") else "Hardware::CPU.arm?"
    if stanza == "on_linux":
        first_predicate = f"{first_predicate} && Hardware::CPU.is_64_bit?"
        second_predicate = f"{second_predicate} && Hardware::CPU.is_64_bit?"

    return f'''  {stanza} do
    if {first_predicate}
      url "{first_url}"
      sha256 "0000000000000000000000000000000000000000000000000000000000000000"
    end

    if {second_predicate}
      url "{second_url}"
      sha256 "0000000000000000000000000000000000000000000000000000000000000000"
    end
  end
'''


def convert_stanza_url_mode_to_targets(
    text: str,
    repository: str,
    tag: str,
    formula: str,
    version: str,
    template: str,
    target_aliases: dict[str, str],
) -> str:
    replacements = {
        "on_macos": target_stanza(
            "on_macos",
            "darwin_arm64",
            "darwin_amd64",
            repository,
            tag,
            formula,
            version,
            template,
            target_aliases,
        ),
        "on_linux": target_stanza(
            "on_linux",
            "linux_arm64",
            "linux_amd64",
            repository,
            tag,
            formula,
            version,
            template,
            target_aliases,
        ),
    }

    for stanza, replacement in replacements.items():
        match = stanza_match(text, stanza)
        if not match:
            raise SystemExit(f"expected {stanza} stanza for target conversion")
        text = text[: match.start()] + replacement + text[match.end() :]
    return text


def remove_stanza(text: str, stanza: str) -> str:
    match = stanza_match(text, stanza)
    if not match:
        return text
    return text[: match.start()] + text[match.end() :]


def remove_top_level_url_sha(text: str) -> str:
    return re.sub(
        r'^\s*url\s+"[^"]+"\n\s*sha256\s+"[0-9a-f]+"\n',
        "",
        text,
        count=1,
        flags=re.MULTILINE,
    )


def insert_target_stanzas(
    text: str,
    repository: str,
    tag: str,
    formula: str,
    version: str,
    template: str,
    target_aliases: dict[str, str],
) -> str:
    text = remove_stanza(text, "on_macos")
    text = remove_stanza(text, "on_linux")
    text = remove_top_level_url_sha(text)

    stanzas = (
        "\n"
        + target_stanza(
            "on_macos",
            "darwin_arm64",
            "darwin_amd64",
            repository,
            tag,
            formula,
            version,
            template,
            target_aliases,
        )
        + "\n"
        + target_stanza(
            "on_linux",
            "linux_arm64",
            "linux_amd64",
            repository,
            tag,
            formula,
            version,
            template,
            target_aliases,
        )
    )

    match = re.search(r'^(\s*license\s+"[^"]+"\n)', text, flags=re.MULTILINE)
    if not match:
        raise SystemExit("target conversion requires a license line")
    return text[: match.end()] + stanzas + text[match.end() :]


def update_top_level_url_and_sha(text: str, url: str, digest: str, version: str) -> str:
    text = replace_url_preserving_interpolation(
        text,
        r'^(?P<prefix>\s*url\s+")(?P<url>[^"]+)(?P<suffix>")',
        url,
        version,
        "top-level url",
    )
    return replace_once(
        text,
        r'^(\s*sha256\s+")[^"]+(")',
        rf'\g<1>{digest}\2',
        "top-level sha256",
    )


def release_artifact_name(url: str) -> str:
    return pathlib.PurePosixPath(urllib.parse.urlparse(url).path).name


def artifact_name_matches_target(
    name: str,
    target: str,
    target_aliases: dict[str, str],
    version: str,
) -> bool:
    version_suffix = rf'[-_.]v?{re.escape(version)}(?:$|[.])'
    for marker in target_markers(target, target_aliases.get(target)):
        pattern = rf'(?:^|[-_.]){re.escape(marker)}(?:$|[.]|{version_suffix})'
        if re.search(pattern, name):
            return True
    return False


def remove_top_level_arm64_dependency_for_universal_macos(
    text: str,
    macos_url: str,
    target_aliases: dict[str, str],
    version: str,
) -> str:
    if not artifact_name_matches_target(
        release_artifact_name(macos_url),
        "darwin_universal",
        target_aliases,
        version,
    ):
        return text

    has_macos_dependency = re.search(
        r'^  depends_on\s+(?::macos\b|(?:maximum_)?macos:)',
        text,
        flags=re.MULTILINE,
    )
    replacement = "" if has_macos_dependency else r"\g<indent>depends_on :macos\n"
    return re.sub(
        r'^(?P<indent>  )depends_on\s+arch:\s+:arm64\s*\n',
        replacement,
        text,
        count=1,
        flags=re.MULTILINE,
    )


def update_version(text: str, version: str) -> str:
    return replace_zero_or_one(
        text,
        r'^(\s*version\s+")[^"]+(")',
        rf'\g<1>{version}\2',
        "version",
    )


def update_cask(cask: str, repository: str, tag: str, artifact: str) -> None:
    version = tag[1:] if tag.startswith("v") else tag
    url = f"https://github.com/{repository}/releases/download/{tag}/{artifact}"
    digest = sha256(url)
    path = pathlib.Path("Casks") / f"{cask}.rb"
    if not path.exists():
        raise SystemExit(f"{path} does not exist; cask creation needs a manual template")

    text = path.read_text()
    text = update_version(text, version)
    text = update_top_level_url_and_sha(text, url, digest, version)
    path.write_text(text)
    print(f"cask: {digest}  {url}")
    print(f"updated {path} to {version}")


def update_repository_metadata(text: str, repository: str) -> str:
    homepage = f"https://github.com/{repository}"
    head = f"{homepage}.git"
    text = replace_zero_or_one(
        text,
        r'^(?P<prefix>\s*homepage\s+")[^"]+(?P<suffix>")',
        rf'\g<prefix>{homepage}\g<suffix>',
        "homepage",
    )
    return replace_zero_or_one(
        text,
        r'^(?P<prefix>\s*head\s+")[^"]+(?P<suffix>"(?:,\s*branch:\s*"[^"]+")?)',
        rf'\g<prefix>{head}\g<suffix>',
        "head",
    )


def main() -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--formula", required=True, help="Formula name, e.g. wacli")
    parser.add_argument("--tag", required=True, help="Release tag, e.g. v0.7.0")
    parser.add_argument("--repository", required=True, help="Source repository, e.g. steipete/wacli")
    parser.add_argument("--assets-json", help="Exact four-platform asset name/SHA-256 JSON")
    parser.add_argument(
        "--description",
        help="Formula description used when creating a missing formula",
    )
    parser.add_argument(
        "--macos-artifact",
        help="macOS release artifact name. Defaults to <formula>-macos-universal.tar.gz",
    )
    parser.add_argument(
        "--linux-url",
        help="Linux source/archive URL. Defaults to the GitHub tag archive",
    )
    parser.add_argument(
        "--artifact-template",
        help=(
            "Release asset template for multi-architecture formulae. "
            "Supports {formula}, {version}, {tag}, and {target}; "
            "defaults to {formula}_{version}_{target}.tar.gz when the formula has per-target URLs."
        ),
    )
    parser.add_argument(
        "--artifact-url",
        help=(
            "Direct top-level artifact/source URL. Supports {formula}, {version}, and {tag}. "
            "Useful for npm tarballs and source archives."
        ),
    )
    parser.add_argument(
        "--target-aliases",
        help=(
            "Comma-separated canonical=artifact-target aliases for custom asset names, "
            "for example darwin_arm64=macos-arm64,linux_amd64=linux-x86_64."
        ),
    )
    parser.add_argument("--cask", help="Optional cask name to update alongside the formula")
    parser.add_argument(
        "--cask-artifact",
        help=(
            "Release asset name for --cask. Supports {formula}, {version}, and {tag}; "
            "required when --cask is set."
        ),
    )
    args = parser.parse_args()

    version = args.tag[1:] if args.tag.startswith("v") else args.tag
    explicit_assets = parse_explicit_assets(args.assets_json)
    if explicit_assets is not None:
        incompatible = [
            name
            for name, value in (
                ("artifact_template", args.artifact_template),
                ("artifact_url", args.artifact_url),
                ("linux_url", args.linux_url),
                ("macos_artifact", args.macos_artifact),
                ("target_aliases", args.target_aliases),
            )
            if value
        ]
        if incompatible:
            raise SystemExit("explicit-assets mode does not support legacy naming inputs: " + ", ".join(incompatible))
    if args.cask and not args.cask_artifact:
        raise SystemExit("--cask-artifact is required when --cask is set")

    macos_artifact = args.macos_artifact or f"{args.formula}-macos-universal.tar.gz"
    macos_url = (
        format_template(args.artifact_url, args.formula, version, args.tag)
        if args.artifact_url
        else f"https://github.com/{args.repository}/releases/download/{args.tag}/{macos_artifact}"
    )
    linux_url = args.linux_url or f"https://github.com/{args.repository}/archive/refs/tags/{args.tag}.tar.gz"
    target_aliases = parse_target_aliases(args.target_aliases)

    path = pathlib.Path("Formula") / f"{args.formula}.rb"
    if not path.exists():
        template = args.artifact_template or "{formula}_{version}_{target}.tar.gz"
        description = args.description or f"{args.formula} command-line tool"
        path.write_text(seed_formula(args.formula, args.repository, version, description, template))
        print(f"created {path}")

    text = path.read_text()
    if explicit_assets is not None:
        verify_explicit_assets(args.repository, args.tag, explicit_assets)
        text = render_explicit_target_formula(text, args.repository, args.tag, version, explicit_assets)
        path.write_text(text)
        print(f"updated {path} to {version} from exact verified release assets")
        if args.cask:
            cask_artifact = format_template(args.cask_artifact, args.formula, version, args.tag)
            update_cask(args.cask, args.repository, args.tag, cask_artifact)
        return 0

    text = update_repository_metadata(text, args.repository)
    has_macos = has_stanza(text, "on_macos")
    has_linux = has_stanza(text, "on_linux")
    targets = ("darwin_amd64", "darwin_arm64", "linux_amd64", "linux_arm64")
    url_sha_pairs = iter_url_sha_pairs(text)
    classified_pairs = [(match, classify_target(match.group("url"), target_aliases, version)) for match in url_sha_pairs]
    target_url_count = sum(1 for _, target in classified_pairs if target)
    has_target_urls = target_url_count > 1 and not uses_stanza_url_mode(text, version)
    if args.artifact_template and not has_target_urls and uses_stanza_url_mode(text, version):
        text = convert_stanza_url_mode_to_targets(
            text,
            args.repository,
            args.tag,
            args.formula,
            version,
            args.artifact_template,
            target_aliases,
        )
        url_sha_pairs = iter_url_sha_pairs(text)
        classified_pairs = [(match, classify_target(match.group("url"), target_aliases, version)) for match in url_sha_pairs]
        target_url_count = sum(1 for _, target in classified_pairs if target)
        has_target_urls = target_url_count > 1
    elif args.artifact_template and not has_target_urls:
        text = insert_target_stanzas(
            text,
            args.repository,
            args.tag,
            args.formula,
            version,
            args.artifact_template,
            target_aliases,
        )
        url_sha_pairs = iter_url_sha_pairs(text)
        classified_pairs = [(match, classify_target(match.group("url"), target_aliases, version)) for match in url_sha_pairs]
        target_url_count = sum(1 for _, target in classified_pairs if target)
        has_target_urls = target_url_count > 1
    if has_macos != has_linux and not has_target_urls:
        raise SystemExit("formulae with only one platform stanza need manual updates")

    text = update_version(text, version)
    url_sha_pairs = iter_url_sha_pairs(text)
    classified_pairs = [(match, classify_target(match.group("url"), target_aliases, version)) for match in url_sha_pairs]
    target_url_count = sum(1 for _, target in classified_pairs if target)
    has_target_urls = target_url_count > 1 and not uses_stanza_url_mode(text, version)

    if has_target_urls:
        template = args.artifact_template or "{formula}_{version}_{target}.tar.gz"
        replacements: list[tuple[int, int, str]] = []
        seen_targets: set[str] = set()
        for match, target in classified_pairs:
            if not target:
                continue
            artifact_target = target_aliases.get(target, target)
            artifact = template.format(
                formula=args.formula,
                version=version,
                tag=args.tag,
                target=artifact_target,
            )
            url = f"https://github.com/{args.repository}/releases/download/{args.tag}/{artifact}"
            digest = sha256(url)
            existing_url = match.group("url")
            replacement_url = url
            if "#{version}" in existing_url and existing_url.replace("#{version}", version) == url:
                replacement_url = existing_url
            replacement = (
                f'{match.group("prefix")}{replacement_url}'
                f'{match.group("middle")}{digest}{match.group("suffix")}'
            )
            replacements.append((match.start(), match.end(), replacement))
            seen_targets.add(target)
            print(f"{target}: {digest}  {url}")
        for target in sorted(set(targets).intersection(seen_targets ^ set(targets))):
            if target_url_count >= 4:
                raise SystemExit(f"failed to update {target} in {path}")
        for start, end, replacement in reversed(replacements):
            text = text[:start] + replacement + text[end:]

        if args.linux_url:
            linux_sha = sha256(linux_url)
            text = replace_zero_or_one(
                text,
                r'(?P<prefix>url "https://github\.com/[^"]+/archive/refs/tags/[^"]+"\n\s+sha256 ")[0-9a-f]+(?P<suffix>")',
                rf'\g<prefix>{linux_sha}\g<suffix>',
                "source archive sha256",
            )
            print(f"Linux source: {linux_sha}  {linux_url}")
    else:
        macos_sha = sha256(macos_url)
        if has_macos:
            text = update_url_and_sha_in_stanza(text, "on_macos", macos_url, macos_sha, version)
            linux_sha = sha256(linux_url)
            text = update_url_and_sha_in_stanza(text, "on_linux", linux_url, linux_sha, version)
        else:
            text = update_top_level_url_and_sha(text, macos_url, macos_sha, version)
            text = remove_top_level_arm64_dependency_for_universal_macos(text, macos_url, target_aliases, version)
            linux_sha = None
        print(f"macOS: {macos_sha}  {macos_url}")
        if linux_sha:
            print(f"Linux: {linux_sha}  {linux_url}")

    path.write_text(text)

    print(f"updated {path} to {version}")
    if args.cask:
        cask_artifact = format_template(args.cask_artifact, args.formula, version, args.tag)
        update_cask(args.cask, args.repository, args.tag, cask_artifact)
    return 0


if __name__ == "__main__":
    sys.exit(main())
