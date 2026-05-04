class Mcporter < Formula
  desc "Model Context Protocol runtime and CLI generator"
  homepage "https://github.com/steipete/mcporter"
  url "https://github.com/steipete/mcporter/releases/download/v0.10.0/mcporter-macos-arm64-v0.10.0.tar.gz"
  sha256 "4b23391b709ea3ba877df283cb1b66c69d361fc8cee6f87d0b5d7fd8838be0e5"
  license "MIT"

  depends_on arch: :arm64

  def install
    bin.install "mcporter"
  end

  test do
    assert_match "Usage: mcporter <command>", shell_output("#{bin}/mcporter", 1)
  end
end
