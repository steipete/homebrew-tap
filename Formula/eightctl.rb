class Eightctl < Formula
  desc "Control Eight Sleep Pods from the terminal"
  homepage "https://github.com/steipete/eightctl"
  version "0.2.8"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/steipete/eightctl/releases/download/v0.2.8/eightctl_0.2.8_darwin_arm64.tar.gz"
      sha256 "5a188f2eba573ce5af2fe626795b78431c35a36b5ab955f006f363dbe24727c2"
    else
      url "https://github.com/steipete/eightctl/releases/download/v0.2.8/eightctl_0.2.8_darwin_amd64.tar.gz"
      sha256 "295760ab7356876347420ef78df0b131937a2b43eb8b8affe8b55b2134b0afc8"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/steipete/eightctl/releases/download/v0.2.8/eightctl_0.2.8_linux_arm64.tar.gz"
      sha256 "0179e0bad9f17bcfbfec836f87d0bb6e77e32d45d37681b62303cda115b096a0"
    else
      url "https://github.com/steipete/eightctl/releases/download/v0.2.8/eightctl_0.2.8_linux_amd64.tar.gz"
      sha256 "8be6f78860e745f805e02ba8f74dd05d07a13e893f4e6e65c1440d4e52815a79"
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
