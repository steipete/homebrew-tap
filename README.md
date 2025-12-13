# steipete's Homebrew Tap 🍺 - Brew tap for shipping my CLI tools fast

This is the official Homebrew tap for steipete's tools and utilities.

## Installation

```bash
brew tap steipete/tap
```

## Available Formulas

### Sonoscli

Control Sonos speakers from the command line (discovery, playback, grouping, Spotify).

**Version:** 0.1.0 (Released December 13, 2025)

```bash
brew install steipete/tap/sonoscli
```

### Wacli

WhatsApp CLI built on top of `whatsmeow`, with local sync + offline search.

```bash
brew install steipete/tap/wacli
```

Note: until the first tagged release, this formula tracks `main`.

### Camsnap

One-command RTSP/ONVIF camera helper for snapshots, clips, and motion alerts.

**Version:** 0.2.0 (Released December 4, 2025)

```bash
brew install steipete/tap/camsnap
```

#### Features

- 📸 Grab snapshots or short clips from RTSP cameras (ffmpeg-powered)
- 🔎 ONVIF discovery to locate cameras on your LAN
- 🎯 Per-camera defaults for transport/client/audio; supports tokenized RTSP paths (UniFi Protect)
- 🚨 Motion watch with action hooks and JSON logging

#### Quick Start

```bash
# Discover cameras (ONVIF)
camsnap discover

# Add a camera with RTSP token (UniFi Protect)
camsnap add --name livingroom --host 192.168.1.1 --port 7447 --protocol rtsp --path YOUR_TOKEN

# Take a snapshot
camsnap snap livingroom --out shot.jpg
```

#### Requirements

- ffmpeg (installed automatically via dependency)

### Poltergeist

Universal file watcher with auto-rebuild for any build system.

**Version:** 2.1.1 (Released November 25, 2025)

```bash
brew install steipete/tap/poltergeist
```

#### Features

- 👻 Auto-detects and rebuilds any project type
- 🚀 Bun-compiled standalone binary (no Node.js required)
- 🔨 Smart build queue with priority-based execution
- 📦 Universal target system (executables, libraries, Docker, etc.)
- 🎯 Intelligent focus detection for multi-project setups
- ⚡ Powered by Facebook's Watchman for efficient file watching

#### Quick Start

```bash
# Initialize configuration
poltergeist init

# Start watching and auto-building
poltergeist haunt

# Check build status
polter status
```

For more information, see [Poltergeist on GitHub](https://github.com/steipete/poltergeist).

### Peekaboo

Lightning-fast macOS screenshot tool with AI vision analysis capabilities.

**Version:** 2.0.1 (Released July 3, 2025)

```bash
brew install steipete/tap/peekaboo
```

#### Features

- 🚀 Native Swift implementation for maximum performance
- 📸 Multiple capture modes (window, screen, frontmost, multi-window)
- 🤖 Built-in AI analysis with OpenAI and Ollama support
- ⚙️ Configuration file support with environment variable expansion
- 🔏 Code signed with Developer ID for security
- 💻 Universal binary (Intel + Apple Silicon)

#### Quick Start

```bash
# Capture a window
peekaboo --app Safari

# Capture with AI analysis
export OPENAI_API_KEY="your-key"
peekaboo --app Safari --analyze "What is shown in this screenshot?"

# Configure Peekaboo
peekaboo config init
peekaboo config edit
```

#### Requirements

- macOS 14.0 (Sonoma) or later
- Screen Recording permission (will be prompted on first use)

For more information, see [Peekaboo on GitHub](https://github.com/steipete/peekaboo).

### Mcporter

TypeScript-based Model Context Protocol runtime and CLI generator.

**Version:** 0.7.1 (Released December 8, 2025)

```bash
brew install steipete/tap/mcporter
```

#### Highlights

- 🔄 Keep-alive daemon now watches all config layers and auto-restarts when files change, so new MCP servers are picked up without manual restarts.
- 🗂️ Bundled config entries (Playwright, iTerm) refreshed to match current server definitions.
- ✅ Added regression coverage for stale-daemon detection to keep long-running agents healthy.
- 🔌 Bun-compiled standalone binary (no Node.js runtime required)
- 🔐 OAuth-friendly runtime that persists tokens and refreshes automatically
- 🧱 Structured config loader with `${ENV}` expansion

For more information, see [mcporter on GitHub](https://github.com/steipete/mcporter).

## Adding the Tap

You only need to tap once:

```bash
brew tap steipete/tap
```

Then you can install any formula from this tap:

```bash
brew install peekaboo
# Future tools can be added here
```

## Updating

To update formulas in this tap:

```bash
brew update
brew upgrade peekaboo
```

## Contributing

If you encounter any issues with these formulas, please file an issue in this repository.

## License

The formulas in this tap are MIT licensed. Individual tools may have their own licenses.
