class Remindctl < Formula
  desc "Fast CLI for Apple Reminders"
  homepage "https://github.com/openclaw/remindctl"
  url "https://github.com/openclaw/remindctl/releases/download/v0.3.8/remindctl-macos.zip"
  sha256 "b1a7ff303bea4fba7dd3c63416e8203ecef51769e87dcb464e8bbf9822363d52"
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
