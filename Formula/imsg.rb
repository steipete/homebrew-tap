class Imsg < Formula
  desc "Send and read iMessage / SMS from the terminal"
  homepage "https://github.com/steipete/imsg"
  url "https://github.com/steipete/imsg/releases/download/v0.2.0/imsg-macos.zip"
  version "0.2.0"
  sha256 "0f6533771b1e11851170d3dcf85b23e7c5d1d28d78d4c225c665435d51d6a8e9"
  license "MIT"

  # macOS Sonoma (14.0) or later required
  depends_on macos: :sonoma

  def install
    odie "imsg is Apple Silicon only (arm64)." if Hardware::CPU.intel?
    bin.install "imsg"
  end

  def post_install
    # Ensure the binary is executable
    chmod 0755, "#{bin}/imsg"
  end

  def caveats
    <<~EOS
      imsg needs Full Disk Access to read the Messages database.

      To grant permission:
      1. Open System Settings > Privacy & Security > Full Disk Access
      2. Enable access for your Terminal application

      To send messages, allow Terminal to control Messages.app:
      System Settings > Privacy & Security > Automation
    EOS
  end

  test do
    assert_match "Send and read iMessage", shell_output("#{bin}/imsg --help")
  end
end
