class Peekaboo < Formula
  desc "Lightning-fast macOS screenshots & AI vision analysis"
  homepage "https://github.com/openclaw/Peekaboo"
  url "https://github.com/openclaw/Peekaboo/releases/download/v3.8.0/peekaboo-macos-universal.tar.gz"
  sha256 "5be06117ed861ac7a87ea1d1e552122db4231bf2cd618ec516d77c66acd39620"
  license "MIT"

  depends_on macos: :sequoia

  def install
    bin.install "peekaboo" => "peekaboo"
  end

  def post_install
    # Ensure the binary is executable
    chmod 0755, bin/"peekaboo"
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
    assert_match "Usage", shell_output("#{bin}/peekaboo --help")
  end
end
