class Eightctl < Formula
  desc "Control Eight Sleep Pods from the terminal"
  homepage "https://github.com/steipete/eightctl"
  version "0.2.12"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/steipete/eightctl/releases/download/v0.2.12/eightctl_0.2.12_darwin_arm64.tar.gz"
      sha256 "244e37bf6520eae8b150180f8f71d0f2f5ffcf94d17bcd2452ae84fb9ae22178"
    else
      url "https://github.com/steipete/eightctl/releases/download/v0.2.12/eightctl_0.2.12_darwin_amd64.tar.gz"
      sha256 "02735a4d2a5023fe380357e9d1c36cd288d4289d972c2d059b825c931cc063d9"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/steipete/eightctl/releases/download/v0.2.12/eightctl_0.2.12_linux_arm64.tar.gz"
      sha256 "9bfa2992bfce19896bd79ee777dcc108a731c326f1eba60aabe37a5baf514d87"
    else
      url "https://github.com/steipete/eightctl/releases/download/v0.2.12/eightctl_0.2.12_linux_amd64.tar.gz"
      sha256 "ac3be8ace339bf4069f8fe44d9592d4790fdc347dfe0f2d64e39e6a3f89bd54f"
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
