class Peekaboo < Formula
  desc "Lightning-fast macOS screenshots & AI vision analysis"
  homepage "https://github.com/steipete/peekaboo"
  url "https://github.com/steipete/peekaboo/releases/download/v2.0.3/peekaboo-macos-universal.tar.gz"
  sha256 "f8eb7a896259128877b23b1fe6235fb540ea2ea97a5c982888e4c5d6dbb0c49c"
  license "MIT"
  version "2.0.3"

  # macOS Sonoma (14.0) or later required
  depends_on macos: :sonoma

  def install
    bin.install "peekaboo"
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
        export PEEKABOO_AI_PROVIDERS="openai/gpt-4o,ollama/llava:latest"
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
    
    # Test JSON output for apps listing
    output = shell_output("#{bin}/peekaboo list apps --json-output")
    parsed = JSON.parse(output)
    assert parsed["success"]
    assert parsed["data"]["applications"].is_a?(Array)
  end
end
