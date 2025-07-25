# steipete's Homebrew Tap

This is the official Homebrew tap for steipete's tools and utilities.

## Installation

```bash
brew tap steipete/tap
```

## Available Formulas

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