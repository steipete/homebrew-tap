class Mcporter < Formula
  desc "Model Context Protocol runtime and CLI generator"
  homepage "https://github.com/steipete/mcporter"
  url "https://github.com/steipete/mcporter/releases/download/v0.3.3/mcporter-macos-arm64-v0.3.3.tar.gz"
  sha256 "bfb21fa81744dafdac5fec7322695839f09e277925038743cbfa321550c2f235"
  license "MIT"
  version "0.3.3"

  depends_on arch: :arm64

  def install
    bin.install "mcporter"
  end

  test do
    assert_match "Usage: mcporter <command>", shell_output("#{bin}/mcporter", 1)
  end
end
