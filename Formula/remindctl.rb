class Remindctl < Formula
  desc "Fast CLI for Apple Reminders"
  homepage "https://github.com/steipete/remindctl"
  url "https://github.com/steipete/remindctl/releases/download/v0.2.0/remindctl-macos.zip"
  sha256 "1d931f010cb11ed617dd0ff3ab273a3a593d0ef341adda0d8b04e3a1af7d0f60"
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
