class Goplaces < Formula
  desc "Modern Go client + CLI for the Google Places API (New)"
  homepage "https://github.com/steipete/goplaces"
  version "0.2.1"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/steipete/goplaces/releases/download/v#{version}/goplaces_#{version}_darwin_arm64.tar.gz"
      sha256 "85a2261cde884b678030f77a62eb0e16b792b917387b4bb1a70ad84c993195ef"
    else
      url "https://github.com/steipete/goplaces/releases/download/v#{version}/goplaces_#{version}_darwin_amd64.tar.gz"
      sha256 "41f91cf1f9b21de2e662ef36d1ca55cd9c844f17f29b4bcb5ad83b7a0291969a"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/steipete/goplaces/releases/download/v#{version}/goplaces_#{version}_linux_arm64.tar.gz"
      sha256 "dcfcc1cf4fc38ce983f3aca34115bd024fc9e74ffe3432e98e807212e6ad9845"
    else
      url "https://github.com/steipete/goplaces/releases/download/v#{version}/goplaces_#{version}_linux_amd64.tar.gz"
      sha256 "a03b05b64f8cfcd382dc22c2815a55c2cd7955f63b3507543146607734eac16d"
    end
  end

  def install
    bin.install "goplaces"
  end

  test do
    system "#{bin}/goplaces", "--version"
  end
end
