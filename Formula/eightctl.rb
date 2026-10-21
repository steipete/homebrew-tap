class Eightctl < Formula
  desc "Control Eight Sleep Pods from the terminal"
  homepage "https://github.com/steipete/eightctl"
  version "0.2.11"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/steipete/eightctl/releases/download/v0.2.11/eightctl_0.2.11_darwin_arm64.tar.gz"
      sha256 "9058f798cc6b0db3ef5c19f48b4fd9e2b2b9620e2e06b01dbd501436ecf2bc0e"
    else
      url "https://github.com/steipete/eightctl/releases/download/v0.2.11/eightctl_0.2.11_darwin_amd64.tar.gz"
      sha256 "21509320104e77f65a3e7d01b66c527c228d545f6894851aec11505017c8b0b1"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/steipete/eightctl/releases/download/v0.2.11/eightctl_0.2.11_linux_arm64.tar.gz"
      sha256 "5bf8708ff34388d69b4fc1eb0eb18e7cd2b48d8c1ae82b1c0e4743894164e71d"
    else
      url "https://github.com/steipete/eightctl/releases/download/v0.2.11/eightctl_0.2.11_linux_amd64.tar.gz"
      sha256 "8c029dd2d60cce51d79af94dcf4ee68dad107c6bc32132ad8c0f3cffac4ce71a"
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
