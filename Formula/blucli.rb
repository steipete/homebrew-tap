class Blucli < Formula
  desc "Play, group, and automate BluOS"
  homepage "https://github.com/steipete/blucli"
  url "https://github.com/steipete/blucli/releases/download/v0.1.4/blucli-macos-arm64.tar.gz"
  version "0.1.4"
  sha256 "2ca8b9b821e1034a54b81f11eb1d28e96f1c407b8c03d2c4806f956aee881c2c"
  license "MIT"

  depends_on arch: :arm64

  def install
    bin.install "blu"
    prefix.install "LICENSE"
    prefix.install "README.md"
  end

  test do
    assert_match version, shell_output("#{bin}/blu --version")
  end
end
