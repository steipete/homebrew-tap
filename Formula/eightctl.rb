class Eightctl < Formula
  desc "Control Eight Sleep Pods from the terminal"
  homepage "https://github.com/steipete/eightctl"
  version "0.2.6"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/steipete/eightctl/releases/download/v0.2.6/eightctl_0.2.6_darwin_arm64.tar.gz"
      sha256 "eff2a69438bb2b60679dc08b215c076a67cf4cb3fe30fa4a366fdb95be9fc50b"
    else
      url "https://github.com/steipete/eightctl/releases/download/v0.2.6/eightctl_0.2.6_darwin_amd64.tar.gz"
      sha256 "02647fe8b801a3087a829c62edb07167fad34a52b7c757e2a20d1553770bac27"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/steipete/eightctl/releases/download/v0.2.6/eightctl_0.2.6_linux_arm64.tar.gz"
      sha256 "a0d20f9be8ff3010f590e400c07cbe012d3c4f42801efffa14bdd54e8fdc2d33"
    else
      url "https://github.com/steipete/eightctl/releases/download/v0.2.6/eightctl_0.2.6_linux_amd64.tar.gz"
      sha256 "bebb90c87139145cbc3a166f8a1d30c5c44c435ff5947867c73c5f0f1421e3a7"
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
