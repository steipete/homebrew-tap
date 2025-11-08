# steipete's Homebrew Tap

This is the official Homebrew tap for steipete's tools and utilities.

## Installation

```bash
brew tap steipete/tap
```

## Available Formulas

### Poltergeist

Universal file watcher with auto-rebuild for any build system.

**Version:** 1.4.0 (Released August 5, 2025)

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

**Version:** 0.4.1 (Released November 8, 2025)

```bash
brew install steipete/tap/mcporter
```

#### Highlights

- 🔌 Bun-compiled standalone binary (no Node.js runtime required)
- 🎨 Generated CLIs inherit the same color-aware help layout as the main binary and reuse each MCP server’s own description/title automatically.
- 🛠️ Restores the default config-import fallback so `mcporter list` works outside repos that ship a `config/mcporter.json`.
- 🔐 OAuth-friendly runtime that persists tokens and refreshes automatically
- 🧱 Structured config loader with `${ENV}` expansion
- 🌐 Call/list servers directly via `https://host/path.tool()` selectors with automatic reuse of configured entries

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
