class Blucli < Formula
  desc "Play, group, and automate BluOS"
  homepage "https://github.com/steipete/blucli"
  url "https://github.com/steipete/blucli/releases/download/v0.1.3/blucli-macos-arm64.tar.gz"
  sha256 "e6ade00b36bade1ee765e5ef9ed2107b2a90673f53dab801e1889ffbcb4af623"
  version "0.1.3"
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
