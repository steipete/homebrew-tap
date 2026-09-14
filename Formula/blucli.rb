class Blucli < Formula
  desc "Play, group, and automate BluOS"
  homepage "https://github.com/steipete/blucli"
  version "0.1.6"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/steipete/blucli/releases/download/v0.1.6/blucli_0.1.6_darwin_arm64.tar.gz"
      sha256 "9022e6e74ba87be259081cb88b2beff17a2796cc028a36e424703d75f1f569a0"
    else
      url "https://github.com/steipete/blucli/releases/download/v0.1.6/blucli_0.1.6_darwin_amd64.tar.gz"
      sha256 "435516bfff849f84d9a3ff6ac6b2487a121671882cafd42544e14b842bb20833"
    end
  end

  on_linux do
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/steipete/blucli/releases/download/v0.1.6/blucli_0.1.6_linux_arm64.tar.gz"
      sha256 "aa57e6ee89c947e552cbbb7f9d444666a452a9f55baeb9731c1b71f89f257445"
    else
      url "https://github.com/steipete/blucli/releases/download/v0.1.6/blucli_0.1.6_linux_amd64.tar.gz"
      sha256 "be9b1067024f74ab0f3198cecfcf3bc4cb505f6caafda617d8c6ea9c9297c8aa"
    end
  end

  def install
    bin.install "blu"
    prefix.install "LICENSE"
    prefix.install "README.md"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/blu --version")
  end
end
