class Gifgrep < Formula
  desc "Grep the GIF. Stick the landing"
  homepage "https://github.com/steipete/gifgrep"
  version "0.4.5"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/steipete/gifgrep/releases/download/v0.4.5/gifgrep_0.4.5_darwin_arm64.tar.gz"
      sha256 "de5afebc29f69e0104841df0c45d5c9954f68d5b82b4881614a8526ff91bc2c8"
    else
      url "https://github.com/steipete/gifgrep/releases/download/v0.4.5/gifgrep_0.4.5_darwin_amd64.tar.gz"
      sha256 "4e509569b39adb7773cf9ded020013ff7a70fcb239b44b603aeccc45542fe2e1"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/steipete/gifgrep/releases/download/v0.4.5/gifgrep_0.4.5_linux_arm64.tar.gz"
      sha256 "9ebcfbeeeb3d0bc42b02ecfcc8a124feb5ddbf18160e55422d60d0e141d6bd9b"
    else
      url "https://github.com/steipete/gifgrep/releases/download/v0.4.5/gifgrep_0.4.5_linux_amd64.tar.gz"
      sha256 "7430fc2d3e544cad7794b9ffab0c99a49983f8dcc37b1816da25d6c6a1453efe"
    end
  end

  def install
    bin.install "gifgrep"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/gifgrep --version")
  end
end
