class Eightctl < Formula
  desc "Control Eight Sleep Pods from the terminal"
  homepage "https://github.com/steipete/eightctl"
  version "0.2.2"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/steipete/eightctl/releases/download/v0.2.2/eightctl_0.2.2_darwin_arm64.tar.gz"
      sha256 "b24bc1edb1c7ff0fe73e0b59e68e3e1e8b22cb0b9618e6ce0a746a4fe4e16166"
    else
      url "https://github.com/steipete/eightctl/releases/download/v0.2.2/eightctl_0.2.2_darwin_amd64.tar.gz"
      sha256 "1f45df196eab566585e7800ca3058f3438eeeadc4ca9c3ad3aff6f2d3d15330e"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/steipete/eightctl/releases/download/v0.2.2/eightctl_0.2.2_linux_arm64.tar.gz"
      sha256 "be666901a4629ffc8a40d5640b28a2b6b2ac921ad8501193b8cc7c7fe6cc50a5"
    else
      url "https://github.com/steipete/eightctl/releases/download/v0.2.2/eightctl_0.2.2_linux_amd64.tar.gz"
      sha256 "47970731dfc64297681654e7695d1423db8f3be38cc7753030171281ce4624cf"
    end
  end

  def install
    bin.install "eightctl"
  end

  test do
    assert_equal version.to_s, shell_output("#{bin}/eightctl version").strip
    assert_match "Control your Eight Sleep Pod", shell_output("#{bin}/eightctl --help")
    assert_match "Show device status", shell_output("#{bin}/eightctl status --help")
  end
end
