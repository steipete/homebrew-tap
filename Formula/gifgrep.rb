class Gifgrep < Formula
  desc "Grep the GIF. Stick the landing"
  homepage "https://github.com/steipete/gifgrep"
  version "0.4.6"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/steipete/gifgrep/releases/download/v0.4.6/gifgrep_0.4.6_darwin_arm64.tar.gz"
      sha256 "42c6450120164d44f926e7c788af3ad42cbe7e0962cc2c5044d9e2d31e921a39"
    else
      url "https://github.com/steipete/gifgrep/releases/download/v0.4.6/gifgrep_0.4.6_darwin_amd64.tar.gz"
      sha256 "a4707286503df73ed49c22f2a77a06853f331e635acdb1fce839353aed956aae"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/steipete/gifgrep/releases/download/v0.4.6/gifgrep_0.4.6_linux_arm64.tar.gz"
      sha256 "f26a41bd16561b126429d7ddd7d6b8a6da96a664f3e8dd70a319fcce478ff037"
    else
      url "https://github.com/steipete/gifgrep/releases/download/v0.4.6/gifgrep_0.4.6_linux_amd64.tar.gz"
      sha256 "36768094df265fe9a9c2dfa2221da4c40d4f7a043ac22ab972c2ad9e1a3ca0a0"
    end
  end

  def install
    bin.install "gifgrep"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/gifgrep --version")
  end
end
