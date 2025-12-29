class Mcporter < Formula
  desc "Model Context Protocol runtime and CLI generator"
  homepage "https://github.com/steipete/mcporter"
  url "https://github.com/steipete/mcporter/releases/download/v0.7.3/mcporter-macos-arm64-v0.7.3.tar.gz"
  sha256 "d8b71971e574bf86b7e24f3fd6db1e13f8c89dbe8704a8b78b806b6e2a628af9"
  license "MIT"

  depends_on arch: :arm64

  def install
    bin.install "mcporter"
  end

  test do
    assert_match "Usage: mcporter <command>", shell_output("#{bin}/mcporter", 1)
  end
end
