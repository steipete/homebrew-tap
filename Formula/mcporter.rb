class Mcporter < Formula
  desc "Model Context Protocol runtime and CLI generator"
  homepage "https://github.com/steipete/mcporter"
  url "https://github.com/steipete/mcporter/releases/download/v0.8.0/mcporter-macos-arm64-v0.8.0.tar.gz"
  sha256 "81c093704e1f0f247f14f2fa7ff0e8206227f9d44d6b8ff4bbd839941d083475"
  license "MIT"

  depends_on arch: :arm64

  def install
    bin.install "mcporter"
  end

  test do
    assert_match "Usage: mcporter <command>", shell_output("#{bin}/mcporter", 1)
  end
end
