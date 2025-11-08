class Mcporter < Formula
  desc "Model Context Protocol runtime and CLI generator"
  homepage "https://github.com/steipete/mcporter"
  url "https://github.com/steipete/mcporter/releases/download/v0.4.1/mcporter-macos-arm64-v0.4.1.tar.gz"
  sha256 "a4508c4b7ad7684ac5ee151f33a31957670aa8ecb4ac3fcf8bb1b839f168744e"
  license "MIT"
  version "0.4.1"

  depends_on arch: :arm64

  def install
    bin.install "mcporter"
  end

  test do
    assert_match "Usage: mcporter <command>", shell_output("#{bin}/mcporter", 1)
  end
end
