class Mcporter < Formula
  desc "Model Context Protocol runtime and CLI generator"
  homepage "https://github.com/steipete/mcporter"
  url "https://github.com/steipete/mcporter/releases/download/v0.4.3/mcporter-macos-arm64-v0.4.3.tar.gz"
  sha256 "b8d833b66576851132689e7178b16ccb5bb7ebbc12cb03d12dd78b2c86f0952d"
  license "MIT"
  version "0.4.3"

  depends_on arch: :arm64

  def install
    bin.install "mcporter"
  end

  test do
    assert_match "Usage: mcporter <command>", shell_output("#{bin}/mcporter", 1)
  end
end
