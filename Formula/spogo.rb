class Spogo < Formula
  desc "Spotify power CLI using web cookies"
  homepage "https://github.com/openclaw/spogo"
  version "0.13.1"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/openclaw/spogo/releases/download/v0.13.1/spogo_0.13.1_darwin_arm64.tar.gz"
      sha256 "8015c27e973a300722877e4f44b1a1923969e4fabafb7ef1dd80cb64b1625760"
    else
      url "https://github.com/openclaw/spogo/releases/download/v0.13.1/spogo_0.13.1_darwin_amd64.tar.gz"
      sha256 "65cd903bf7ac7fda7a174dcf3da0d872ea497f7c2608fa911d3878ee51cff4f9"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/openclaw/spogo/releases/download/v0.13.1/spogo_0.13.1_linux_arm64.tar.gz"
      sha256 "a55a19814ab927acd904bc618229ace25624d75f586161bfa83cd4158ac415c0"
    else
      url "https://github.com/openclaw/spogo/releases/download/v0.13.1/spogo_0.13.1_linux_amd64.tar.gz"
      sha256 "e1d50793fc605208f4e7a459f4fada4363ce90f55eea7d99239750d183160806"
    end
  end

  def install
    bin.install "spogo"
  end

  test do
    assert_match "spogo", shell_output("#{bin}/spogo --help")
  end
end
