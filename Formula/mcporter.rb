class Mcporter < Formula
  desc "Model Context Protocol runtime and CLI generator"
  homepage "https://github.com/steipete/mcporter"
  url "https://github.com/steipete/mcporter/releases/download/v0.3.6/mcporter-macos-arm64-v0.3.6.tar.gz"
  sha256 "cbbb4509ec98d95f1b875c09d6604b530faca74ccc0316d02411e0eb4ec21a92"
  license "MIT"
  version "0.3.6"

  depends_on arch: :arm64

  def install
    bin.install "mcporter"
  end

  test do
    assert_match "Usage: mcporter <command>", shell_output("#{bin}/mcporter", 1)
  end
end
