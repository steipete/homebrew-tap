class Mcporter < Formula
  desc "Model Context Protocol runtime and CLI generator"
  homepage "https://github.com/steipete/mcporter"
  url "https://github.com/steipete/mcporter/releases/download/v0.3.5/mcporter-macos-arm64-v0.3.5.tar.gz"
  sha256 "a7638e9a515ae4116c0f91fd95ccc9bd33af2b5a48d039385bdedbe539fd5c69"
  license "MIT"
  version "0.3.5"

  depends_on arch: :arm64

  def install
    bin.install "mcporter"
  end

  test do
    assert_match "Usage: mcporter <command>", shell_output("#{bin}/mcporter", 1)
  end
end
