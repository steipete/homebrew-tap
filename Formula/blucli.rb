class Blucli < Formula
  desc "Play, group, and automate BluOS"
  homepage "https://github.com/steipete/blucli"
  url "https://github.com/steipete/blucli/releases/download/v0.1.2/blucli-macos-arm64.tar.gz"
  sha256 "6ca8654b6ba792bc298333747baf0f531ca6a2125ef23ce281884763b4812f05"
  version "0.1.2"
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

