class Peekaboo < Formula
  desc "Lightning-fast macOS screenshots & AI vision analysis"
  homepage "https://github.com/steipete/peekaboo"
  url "https://github.com/steipete/peekaboo/releases/download/v3.0.0-beta3/peekaboo-macos-universal.tar.gz"
  sha256 "77eadf6fd5c54eac64b4844d5cc887890b6d6f45d49af61b05c6e29ea2cbd245"
  license "MIT"
  version "3.0.0-beta3"

  # macOS Sonoma (14.0) or later required
  depends_on macos: :sonoma

  def install
    bin.install "peekaboo" => "peekaboo"
  end

  def post_install
    # Ensure the binary is executable
    chmod 0755, "#{bin}/peekaboo"
  end

  def caveats
    <<~EOS
      Peekaboo requires Screen Recording permission to capture screenshots.

      To grant permission:
      1. Open System Settings > Privacy & Security > Screen & System Audio Recording
      2. Enable access for your Terminal application

      For AI analysis features, configure your AI providers:
        export PEEKABOO_AI_PROVIDERS="openai/gpt-5.1,anthropic/claude-sonnet-4.5"
        export OPENAI_API_KEY="your-api-key"

      Or create a config file:
        peekaboo config init
    EOS
  end

  test do
    # Test that the binary runs and returns version
    assert_match "Peekaboo", shell_output("#{bin}/peekaboo --version")

    # Test help command
    assert_match "USAGE:", shell_output("#{bin}/peekaboo --help")
  end
end
