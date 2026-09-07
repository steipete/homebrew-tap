class Remindctl < Formula
  desc "Fast CLI for Apple Reminders"
  homepage "https://github.com/openclaw/remindctl"
  url "https://github.com/openclaw/remindctl/releases/download/v0.3.5/remindctl-macos.zip"
  sha256 "3b060c4f61987779b15af1dfc42d77e6893892343a60b295eff7966e527a365d"
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
