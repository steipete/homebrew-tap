class Mcporter < Formula
  desc "Model Context Protocol runtime and CLI generator"
  homepage "https://github.com/steipete/mcporter"
  url "https://github.com/steipete/mcporter/releases/download/v0.5.0/mcporter-macos-arm64-v0.5.0.tar.gz"
  sha256 "0d1102a65bc3e94f9c53c929b39d9fc3eece26e7b9b7a233727c7601c96983a3"
  license "MIT"
  version "0.5.0"

  depends_on arch: :arm64

  def install
    bin.install "mcporter"
  end

  test do
    assert_match "Usage: mcporter <command>", shell_output("#{bin}/mcporter", 1)
  end
end
