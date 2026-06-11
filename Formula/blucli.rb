class Blucli < Formula
  desc "Play, group, and automate BluOS"
  homepage "https://github.com/steipete/blucli"
  version "0.1.5"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/steipete/blucli/releases/download/v0.1.5/blucli_0.1.5_darwin_arm64.tar.gz"
      sha256 "2c299ea44715e4b370d679157e11be634ef50be05c01758d77ba6edaece51bd1"
    else
      url "https://github.com/steipete/blucli/releases/download/v0.1.5/blucli_0.1.5_darwin_amd64.tar.gz"
      sha256 "d404fa395d3d100fecedd60ffe4e99ca4de00e9826c38c2a8d4a1c438137ecf0"
    end
  end

  on_linux do
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/steipete/blucli/releases/download/v0.1.5/blucli_0.1.5_linux_arm64.tar.gz"
      sha256 "e503ce2c085b5ab55883a0784d43ad5d81152b13dcda72d272f25310bae8d40b"
    else
      url "https://github.com/steipete/blucli/releases/download/v0.1.5/blucli_0.1.5_linux_amd64.tar.gz"
      sha256 "3ec5d6a1293d3abd251dd83afa56f1eb5ad5f7a62a73b1440fb1d9fe151d0585"
    end
  end

  def install
    bin.install "blu"
    prefix.install "LICENSE"
    prefix.install "README.md"
  end

  test do
    assert_match version, shell_output("#{bin}/blu --version")
  end
end
