class Mcporter < Formula
  desc "Model Context Protocol runtime and CLI generator"
  homepage "https://github.com/steipete/mcporter"
  url "https://github.com/steipete/mcporter/releases/download/v0.3.0/mcporter-macos-arm64-v0.3.0.tar.gz"
  sha256 "ece5de37252898bdc89928a5f267bf157573057593b24f927196f9854ebc809a"
  license "MIT"
  version "0.3.0"

  depends_on arch: :arm64

  def install
    bin.install "mcporter"
  end

  test do
    assert_match "Usage: mcporter <command>", shell_output("#{bin}/mcporter", 1)
  end
end
