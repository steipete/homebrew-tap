class Eightctl < Formula
  desc "Control Eight Sleep Pods from the terminal"
  homepage "https://github.com/steipete/eightctl"
  version "0.2.9"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/steipete/eightctl/releases/download/v0.2.9/eightctl_0.2.9_darwin_arm64.tar.gz"
      sha256 "fad3409799e6a016e041c5bcfb7ad2aa808808ae36108b622959d52462007f21"
    else
      url "https://github.com/steipete/eightctl/releases/download/v0.2.9/eightctl_0.2.9_darwin_amd64.tar.gz"
      sha256 "397ca43240b3985841a7aaaacdb78a297e18c6fe19a5d5b95ba19092456321d9"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/steipete/eightctl/releases/download/v0.2.9/eightctl_0.2.9_linux_arm64.tar.gz"
      sha256 "6cd1e3cadd2876f16bcc687e6e7c509a79f9836d38f2d979a2010b4aa60edcda"
    else
      url "https://github.com/steipete/eightctl/releases/download/v0.2.9/eightctl_0.2.9_linux_amd64.tar.gz"
      sha256 "5f8c598689fd5e0cf48f0366693faf31dd341b82892d2708a4340392f593bf3e"
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
