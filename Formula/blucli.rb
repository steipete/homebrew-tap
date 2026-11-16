class Blucli < Formula
  desc "Play, group, and automate BluOS"
  homepage "https://github.com/steipete/blucli"
  version "0.1.10"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/steipete/blucli/releases/download/v0.1.10/blucli_0.1.10_darwin_arm64.tar.gz"
      sha256 "75467904b24943b4efeb0a9082956135f8891c8564aff2f6a11ef581b2237e15"
    else
      url "https://github.com/steipete/blucli/releases/download/v0.1.10/blucli_0.1.10_darwin_amd64.tar.gz"
      sha256 "9ce02557409d987d298468cecb9bb5b32959d7d479663f00a7832512f7adadb6"
    end
  end

  on_linux do
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/steipete/blucli/releases/download/v0.1.10/blucli_0.1.10_linux_arm64.tar.gz"
      sha256 "0fb501a9cd311ec05193756f07d9bc94e1c9635bbe655b2f2063132bbb0fa1ae"
    else
      url "https://github.com/steipete/blucli/releases/download/v0.1.10/blucli_0.1.10_linux_amd64.tar.gz"
      sha256 "6cfa1edee57b64ad58fd84be826e3382c00aede0e6e14faa92e717dd908ad7c9"
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
