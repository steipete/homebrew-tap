class Mcporter < Formula
  desc "Model Context Protocol runtime and CLI generator"
  homepage "https://github.com/steipete/mcporter"
  url "https://github.com/steipete/mcporter/releases/download/v0.6.3/mcporter-macos-arm64-v0.6.3.tar.gz"
  sha256 "34e8c972077349b37858d5a498f510b26075489fc2e35e81f846d99d4c326608"
  license "MIT"
  version "0.6.3"

  depends_on arch: :arm64

  def install
    bin.install "mcporter"
  end

  test do
    assert_match "Usage: mcporter <command>", shell_output("#{bin}/mcporter", 1)
  end
end
