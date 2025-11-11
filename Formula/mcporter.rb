class Mcporter < Formula
  desc "Model Context Protocol runtime and CLI generator"
  homepage "https://github.com/steipete/mcporter"
  url "https://github.com/steipete/mcporter/releases/download/v0.5.6/mcporter-macos-arm64-v0.5.6.tar.gz"
  sha256 "640721615c872766ef43c6456d16ed691b25786f7c61e280dd65928fb6d85768"
  license "MIT"
  version "0.5.6"

  depends_on arch: :arm64

  def install
    bin.install "mcporter"
  end

  test do
    assert_match "Usage: mcporter <command>", shell_output("#{bin}/mcporter", 1)
  end
end
