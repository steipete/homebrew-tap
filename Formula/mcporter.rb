class Mcporter < Formula
  desc "Model Context Protocol runtime and CLI generator"
  homepage "https://github.com/steipete/mcporter"
  url "https://github.com/steipete/mcporter/releases/download/v0.8.1/mcporter-macos-arm64-v0.8.1.tar.gz"
  sha256 "7f726f70801bdded163699b53fade8b602c18f0dbc07851ce5ddad8e0e8bcb3b"
  license "MIT"

  depends_on arch: :arm64

  def install
    bin.install "mcporter"
  end

  test do
    assert_match "Usage: mcporter <command>", shell_output("#{bin}/mcporter", 1)
  end
end
