class Mcporter < Formula
  desc "Model Context Protocol runtime and CLI generator"
  homepage "https://github.com/steipete/mcporter"
  url "https://github.com/steipete/mcporter/releases/download/v0.3.2/mcporter-macos-arm64-v0.3.2.tar.gz"
  sha256 "5be77851ccd42d7cd571b4cb824f1aecb35c858dec19be2549410434b4e25c04"
  license "MIT"
  version "0.3.2"

  depends_on arch: :arm64

  def install
    bin.install "mcporter"
  end

  test do
    assert_match "Usage: mcporter <command>", shell_output("#{bin}/mcporter", 1)
  end
end
