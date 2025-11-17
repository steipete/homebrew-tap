class Mcporter < Formula
  desc "Model Context Protocol runtime and CLI generator"
  homepage "https://github.com/steipete/mcporter"
  url "https://github.com/steipete/mcporter/releases/download/v0.6.0/mcporter-macos-arm64-v0.6.0.tar.gz"
  sha256 "1f6264fd46f68675330b4fee66beacfd7c84991f3a240566c8e716781627fe82"
  license "MIT"
  version "0.6.0"

  depends_on arch: :arm64

  def install
    bin.install "mcporter"
  end

  test do
    assert_match "Usage: mcporter <command>", shell_output("#{bin}/mcporter", 1)
  end
end
