class Mcporter < Formula
  desc "Model Context Protocol runtime and CLI generator"
  homepage "https://github.com/steipete/mcporter"
  url "https://github.com/steipete/mcporter/releases/download/v0.5.3/mcporter-macos-arm64-v0.5.3.tar.gz"
  sha256 "a9a32a5409bfb6ffebeb1d1abcc2d9c2c34754f8410dc12e307f30477611a327"
  license "MIT"
  version "0.5.3"

  depends_on arch: :arm64

  def install
    bin.install "mcporter"
  end

  test do
    assert_match "Usage: mcporter <command>", shell_output("#{bin}/mcporter", 1)
  end
end
