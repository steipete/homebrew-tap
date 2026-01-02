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

- `bird` — Fast X CLI for tweeting, replying, and reading
- `blucli` — Play, group, and automate BluOS
- `camsnap` — One command to grab frames, clips, or motion alerts from RTSP/ONVIF cams
- `gogcli` — Google CLI for Gmail, Calendar, Drive, and Contacts
- `gifgrep` — Grep the GIF. Stick the landing.
- `imsg` — Send and read iMessage / SMS from the terminal
- `mcporter` — Model Context Protocol runtime and CLI generator
- `oracle` — Bundle prompts + files for second-model review
- `ordercli` — Multi-provider order CLI (Foodora, Deliveroo)
- `peekaboo` — Lightning-fast macOS screenshots & AI vision analysis
- `poltergeist` — Universal file watcher with auto-rebuild for any language or build system
- `sag` — Command-line ElevenLabs TTS with mac-style flags
- `sonoscli` — Control Sonos speakers from the command line
- `songsee` — Spectral visualization CLI for audio files
- `summarize` — Link → clean text → summary
- `tmuxwatch` — Live tmux dashboard with Bubble Tea UI
- `wacli` — WhatsApp CLI built on whatsmeow

### Casks

- `codexbar` — Menu bar usage monitor for Codex and Claude
- `repobar` — Menu bar GitHub repo status at a glance
- `trimmy` — Paste-once, run-once clipboard cleaner for terminal snippets

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
- `wacli` also supports `brew install --HEAD steipete/tap/wacli` to build from `main`.

## Manual Cleanup (formulae)

Homebrew formulae don’t support `--zap`. Delete these to “factory reset”:

- `bird`: `~/.config/bird/`
- `blucli`: `~/Library/Application Support/blu/` + `~/Library/Caches/blu/`
- `camsnap`: `~/.config/camsnap/config.yaml`
- `gogcli`: `~/Library/Application Support/gogcli/` (incl `keyring/`, `state/`)
- `mcporter`: `~/.mcporter/`
- `oracle`: `~/.oracle/`
- `ordercli`: `~/Library/Application Support/ordercli/config.json`
- `sonoscli`: `~/Library/Application Support/sonoscli/config.json`
- `summarize`: `~/.summarize/`
- `wacli`: `~/.wacli/`

## Local Source Checkouts (Peter)

All referenced projects live next to this repo under `~/Projects/<repo>`.
