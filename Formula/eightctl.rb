class Eightctl < Formula
  desc "Control Eight Sleep Pods from the terminal"
  homepage "https://github.com/steipete/eightctl"
  version "0.2.5"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/steipete/eightctl/releases/download/v0.2.5/eightctl_0.2.5_darwin_arm64.tar.gz"
      sha256 "6b4680a7a7e7a7064a787674f0add63736d9aaefa3bb628ccfecbd28aa7b4ba8"
    else
      url "https://github.com/steipete/eightctl/releases/download/v0.2.5/eightctl_0.2.5_darwin_amd64.tar.gz"
      sha256 "0671912b3a4d974864e24b40c8bb94565de10f7cf7195ec4d0da6f1440449181"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/steipete/eightctl/releases/download/v0.2.5/eightctl_0.2.5_linux_arm64.tar.gz"
      sha256 "ef9d4fa12212047a9d621ddcb6419a4fe705ed9f690ecd97f6861769fb7bea4c"
    else
      url "https://github.com/steipete/eightctl/releases/download/v0.2.5/eightctl_0.2.5_linux_amd64.tar.gz"
      sha256 "074e83e9dc2bedb767598c86c1a6d4f00b538f3d8d7117c307f87bec162fb572"
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
