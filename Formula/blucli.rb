class Blucli < Formula
  desc "Play, group, and automate BluOS"
  homepage "https://github.com/steipete/blucli"
  version "0.1.4"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/steipete/blucli/releases/download/v0.1.4/blucli-macos-arm64.tar.gz"
      sha256 "2ca8b9b821e1034a54b81f11eb1d28e96f1c407b8c03d2c4806f956aee881c2c"
    else
      url "https://github.com/steipete/blucli/releases/download/v0.1.4/blucli-macos-amd64.tar.gz"
      sha256 "81a9e1b60385e8491a0a33e6a4d8b1ef15b1e736844fe7c42674545d04df4c25"
    end
  end

  on_linux do
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/steipete/blucli/releases/download/v0.1.4/blucli-linux-arm64.tar.gz"
      sha256 "5688640a800e83dd1b9281bc37f87b9375db38729a1eaa561adda8577117338a"
    else
      url "https://github.com/steipete/blucli/releases/download/v0.1.4/blucli-linux-amd64.tar.gz"
      sha256 "195617a6070050ebfaf08aa28acd68320451e2bdbece6b3d2d5ba93bb603cd42"
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
