class Mcporter < Formula
  desc "Model Context Protocol runtime and CLI generator"
  homepage "https://github.com/steipete/mcporter"
  url "https://github.com/steipete/mcporter/releases/download/v0.7.0/mcporter-macos-arm64-v0.7.0.tar.gz"
  sha256 "aa70885d4612f9dd765c339a1f6d8485de61f7a97902da57bb8538a6f8c8afc0"
  license "MIT"

  depends_on arch: :arm64

  def install
    bin.install "mcporter"
  end

  test do
    assert_match "Usage: mcporter <command>", shell_output("#{bin}/mcporter", 1)
  end
end
