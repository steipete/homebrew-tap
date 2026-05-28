class Remindctl < Formula
  desc "Fast CLI for Apple Reminders"
  homepage "https://github.com/steipete/remindctl"
  url "https://github.com/steipete/remindctl/releases/download/v0.3.0/remindctl-macos.zip"
  sha256 "86f06b2b8a71b2dd96dc1a35fa21b660ed0f17b21cf7a1f91f4eb0df9502339e"
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
