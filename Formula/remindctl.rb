class Remindctl < Formula
  desc "Fast CLI for Apple Reminders"
  homepage "https://github.com/steipete/remindctl"
  url "https://github.com/steipete/remindctl/releases/download/v0.3.2/remindctl-macos.zip"
  sha256 "0291b62ed50ff5ac01115c4c01bdbad5e9c12c51b75705cfdb16d0d492455a0f"
  license "MIT"

  depends_on macos: :sonoma

  def install
    bin.install "remindctl"
  end

  def caveats
    <<~EOS
      remindctl needs Reminders access.
      System Settings > Privacy & Security > Reminders
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/remindctl --version")
    assert_match "Manage Apple Reminders", shell_output("#{bin}/remindctl --help")
  end
end
