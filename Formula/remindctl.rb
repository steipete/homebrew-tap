class Remindctl < Formula
  desc "Fast CLI for Apple Reminders"
  homepage "https://github.com/steipete/remindctl"
  url "https://github.com/steipete/remindctl/archive/d8f95101127db8bd00da3d98e3c4dd4e44a8d17e.tar.gz"
  version "0.1.0"
  sha256 "2dadf9776a5672f7ac7f1537cd215d2f1d7fc417d80f77cb2c9053c6d9da98b7"
  license "MIT"

  depends_on macos: :sonoma

  def install
    system "scripts/generate-version.sh"
    system "swift", "build", "-c", "release", "--product", "remindctl"
    bin.install ".build/release/remindctl"
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
