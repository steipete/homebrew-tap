class Eightctl < Formula
  desc "Control Eight Sleep Pods from the terminal"
  homepage "https://github.com/steipete/eightctl"
  version "0.2.10"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/steipete/eightctl/releases/download/v0.2.10/eightctl_0.2.10_darwin_arm64.tar.gz"
      sha256 "c2dd0cfc696e862366398acfe0fd0de62261c68e8c0d4a018f65875368d463b1"
    else
      url "https://github.com/steipete/eightctl/releases/download/v0.2.10/eightctl_0.2.10_darwin_amd64.tar.gz"
      sha256 "f171ce89db6668e097a262e51ff5b943f7c9f75e398c809df324c04d4430e9be"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/steipete/eightctl/releases/download/v0.2.10/eightctl_0.2.10_linux_arm64.tar.gz"
      sha256 "c2a79e3b0555d9ad109d7da9ef0cceb593c4101944f1297b4319bc5827c7305d"
    else
      url "https://github.com/steipete/eightctl/releases/download/v0.2.10/eightctl_0.2.10_linux_amd64.tar.gz"
      sha256 "d4691e99a534b75504cec22836749aece0195d4fdc9941954dca2c4afadcdbb6"
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
