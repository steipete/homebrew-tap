class Blucli < Formula
  desc "Play, group, and automate BluOS"
  homepage "https://github.com/steipete/blucli"
  version "0.1.8"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/steipete/blucli/releases/download/v0.1.8/blucli_0.1.8_darwin_arm64.tar.gz"
      sha256 "a1642062098b76af3dbc50365479420649b7c958b8e3336ca33460e413e620cf"
    else
      url "https://github.com/steipete/blucli/releases/download/v0.1.8/blucli_0.1.8_darwin_amd64.tar.gz"
      sha256 "2cc43ffb8739a19d0313483eb316d873b5dc0f7eb33b51220f06657469e7e6ed"
    end
  end

  on_linux do
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/steipete/blucli/releases/download/v0.1.8/blucli_0.1.8_linux_arm64.tar.gz"
      sha256 "729b9b799cd0bb74a16adca2e9d8d49ffa39e38c203cf204a123c00ba53849ba"
    else
      url "https://github.com/steipete/blucli/releases/download/v0.1.8/blucli_0.1.8_linux_amd64.tar.gz"
      sha256 "81fce0203f9051cc77ac5862ea85c802537f978ebf2a9b43e72d5a4dcb15240d"
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
