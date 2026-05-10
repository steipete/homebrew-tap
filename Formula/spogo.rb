class Spogo < Formula
  desc "Spotify power CLI using web cookies"
  homepage "https://github.com/openclaw/spogo"
  version "0.9.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/openclaw/spogo/releases/download/v0.9.0/spogo_0.9.0_darwin_arm64.tar.gz"
      sha256 "e5b23dd56c0808481f14cf2d4481a8a26bebd538c4a364341d949b393ee3765b"
    else
      url "https://github.com/openclaw/spogo/releases/download/v0.9.0/spogo_0.9.0_darwin_amd64.tar.gz"
      sha256 "a1dc5002b9ab203d3103ed0e1f2082713230b61da36b166b3308c1a377226ca9"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/openclaw/spogo/releases/download/v0.9.0/spogo_0.9.0_linux_arm64.tar.gz"
      sha256 "e9a8a1c38a13df8a9cda2cc9fdc0e6c7604aa73baec5a1408fe761d8cbcfe32f"
    else
      url "https://github.com/openclaw/spogo/releases/download/v0.9.0/spogo_0.9.0_linux_amd64.tar.gz"
      sha256 "530e3783b0a8b9b0e35b29bf3a10dcebd0e920308fe5a2c3ef72367f92d3725c"
    end
  end

  def install
    bin.install "spogo"
  end

  test do
    assert_match "spogo", shell_output("#{bin}/spogo --help")
  end
end
