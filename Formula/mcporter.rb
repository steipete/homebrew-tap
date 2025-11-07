class Mcporter < Formula
  desc "Model Context Protocol runtime and CLI generator"
  homepage "https://github.com/steipete/mcporter"
  url "https://github.com/steipete/mcporter/releases/download/v0.3.1/mcporter-macos-arm64-v0.3.1.tar.gz"
  sha256 "7973dd52ca9f30b3458c54436210243fb06b209ee773a6c50d94797c312f94f6"
  license "MIT"
  version "0.3.1"

  depends_on arch: :arm64

  def install
    bin.install "mcporter"
  end

  test do
    assert_match "Usage: mcporter <command>", shell_output("#{bin}/mcporter", 1)
  end
end
