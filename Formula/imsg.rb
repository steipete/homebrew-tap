class Imsg < Formula
  desc "Send and read iMessage / SMS from the terminal"
  homepage "https://github.com/steipete/imsg"
  url "https://github.com/steipete/imsg/releases/download/v0.4.0/imsg-macos.zip"
  version "0.4.0"
  sha256 "d0e5e333ee88192d595bfed9eece60e35ecad0300145966d5ad27458c33e407b"
  license "MIT"

  # macOS Sonoma (14.0) or later required
  depends_on macos: :sonoma

  def install
    bin.install "imsg"
    bin.install "PhoneNumberKit_PhoneNumberKit.bundle"
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
    assert_match version.to_s, shell_output("#{bin}/imsg --version")
    assert_match "Send and read iMessage", shell_output("#{bin}/imsg --help")
  end
end
