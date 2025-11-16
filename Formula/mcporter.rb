class Mcporter < Formula
  desc "Model Context Protocol runtime and CLI generator"
  homepage "https://github.com/steipete/mcporter"
  url "https://github.com/steipete/mcporter/releases/download/v0.5.10/mcporter-macos-arm64-v0.5.10.tar.gz"
  sha256 "210166b913c5471486340a982353044f5ca337667c20607c841b51aee3f866fe"
  license "MIT"
  version "0.5.10"

  depends_on arch: :arm64

  def install
    bin.install "mcporter"
  end

  test do
    assert_match "Usage: mcporter <command>", shell_output("#{bin}/mcporter", 1)
  end
end
