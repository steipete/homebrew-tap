class Mcporter < Formula
  desc "Model Context Protocol runtime and CLI generator"
  homepage "https://github.com/steipete/mcporter"
  url "https://github.com/steipete/mcporter/releases/download/v0.5.8/mcporter-macos-arm64-v0.5.8.tar.gz"
  sha256 "1c3aa296119063a4e305ee85b872b161f4f8db36c2ffae3729ab7c33cde61044"
  license "MIT"
  version "0.5.8"

  depends_on arch: :arm64

  def install
    bin.install "mcporter"
  end

  test do
    assert_match "Usage: mcporter <command>", shell_output("#{bin}/mcporter", 1)
  end
end
