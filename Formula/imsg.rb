class Imsg < Formula
  desc "Send and read iMessage / SMS from the terminal"
  homepage "https://github.com/steipete/imsg"
  url "https://github.com/steipete/imsg/releases/download/v0.7.1/imsg-macos.zip"
  sha256 "05d393548485f23e2c157c4b904819dfd1eb41e83e1d010e4f854537c654282c"
  license "MIT"

  # macOS Sonoma (14.0) or later required
  depends_on macos: :sonoma

  def install
    libexec.install "imsg"
    Dir["*.bundle"].each do |bundle|
      libexec.install bundle
    end
    bin.write_exec_script libexec/"imsg"
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
    assert_match version.to_s, shell_output("#{bin}/imsg --version")
    assert_match "Send and read iMessage", shell_output("#{bin}/imsg --help")
  end
end
