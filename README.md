# steipete’s Homebrew Tap

Homebrew tap for shipping my CLI tools + a few macOS apps.

## Install

```bash
brew tap steipete/tap
```

## Install Packages

```bash
# formula
brew install steipete/tap/<name>

# cask
brew install --cask steipete/tap/<name>
```

## Packages

### Formulae

- `blucli` — Play, group, and automate BluOS
- `birdclaw` — Local Twitter memory for archives, DMs, likes, bookmarks, and moderation
- `camsnap` — One command to grab frames, clips, or motion alerts from RTSP/ONVIF cams
- `codexbar` — CodexBar CLI (Linuxbrew)
- `eightctl` — Control Eight Sleep Pods from the terminal
- `gifgrep` — Grep the GIF. Stick the landing.
- `imsg` — Send and read iMessage / SMS from the terminal
- `mcporter` — Model Context Protocol runtime and CLI generator (`0.12.3`: typed-array signatures and refreshed dependencies)
- `oracle` — Bundle prompts + files for second-model review
- `ordercli` — Multi-provider order CLI (Foodora, Deliveroo)
- `peekaboo` — Lightning-fast macOS screenshots & AI vision analysis
- `poltergeist` — Universal file watcher with auto-rebuild for any language or build system
- `sag` — Command-line ElevenLabs TTS with mac-style flags
- `sonoscli` — Control Sonos speakers from the command line
- `songsee` — Spectral visualization CLI for audio files
- `tmuxwatch` — Live tmux dashboard with Bubble Tea UI

### Casks

- `blackbar` — Menu bar app for Blacksmith CI status and live vCPU usage
- `codexbar` — Menu bar usage monitor for Codex and Claude
- `repobar` — Menu bar GitHub repo status at a glance
- `trimmy` — Paste-once, run-once clipboard cleaner for terminal snippets

## Updating Formulae

Run the `Update Formula` workflow with:

- `formula`: formula name, e.g. `tmuxwatch`
- `tag`: release tag, e.g. `v0.7.0`
- `repository`: source repository, e.g. `steipete/tmuxwatch`

The workflow updates regular single-URL formulae, formulae with separate `on_macos` and `on_linux` stanzas, duplicate source-build URLs inside a stanza, and target-specific binary formulae when `artifact_template` is provided. Formulae with unsupported custom platform layouts still need manual updates.

OpenClaw-owned formulae live in `openclaw/tap`; migrated names are listed in `tap_migrations.json`.

## Update / Uninstall

```bash
brew update
brew upgrade

brew uninstall <formula>
brew uninstall --cask <cask>

# casks only: remove user data
brew uninstall --cask --zap steipete/tap/codexbar
```

## Notes

- Run `brew info steipete/tap/<name>` for per-tool caveats (permissions, setup steps, etc.).

## Manual Cleanup (formulae)

Homebrew formulae don’t support `--zap`. Delete these to “factory reset”:

- `blucli`: `~/Library/Application Support/blu/` + `~/Library/Caches/blu/`
- `birdclaw`: `~/.birdclaw/`
- `camsnap`: `~/.config/camsnap/config.yaml`
- `eightctl`: `~/.config/eightctl/config.yaml`
- `mcporter`: `~/.mcporter/`
- `oracle`: `~/.oracle/`
- `ordercli`: `~/Library/Application Support/ordercli/config.json`
- `sonoscli`: `~/Library/Application Support/sonoscli/config.json`

## Local Source Checkouts (Peter)

All referenced projects live next to this repo under `~/Projects/<repo>`.
