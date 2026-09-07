class Remindctl < Formula
  desc "Fast CLI for Apple Reminders"
  homepage "https://github.com/openclaw/remindctl"
  url "https://github.com/openclaw/remindctl/releases/download/v0.3.6/remindctl-macos.zip"
  sha256 "77b7d2e6f30796699bb4c35bb1d91b692c1284db3127eb9b8ffad24800ee20bb"
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
