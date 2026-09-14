class Spogo < Formula
  desc "Spotify power CLI using web cookies"
  homepage "https://github.com/openclaw/spogo"
  version "0.13.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/openclaw/spogo/releases/download/v0.13.0/spogo_0.13.0_darwin_arm64.tar.gz"
      sha256 "6d998332b50a4366c80bc8dc0a4513539cda3d2d4fd39ffa996e779793cfd32e"
    else
      url "https://github.com/openclaw/spogo/releases/download/v0.13.0/spogo_0.13.0_darwin_amd64.tar.gz"
      sha256 "2e3ad8bffc729e2700c4c61e44cb5b3316d586d9e3414e73c408b6a4e6abaf83"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/openclaw/spogo/releases/download/v0.13.0/spogo_0.13.0_linux_arm64.tar.gz"
      sha256 "9c0f8376b6ae318c473b6fa9c685dad1ea4c01f9e3f370be92d2086212609887"
    else
      url "https://github.com/openclaw/spogo/releases/download/v0.13.0/spogo_0.13.0_linux_amd64.tar.gz"
      sha256 "914ef5d445b708f9c2d357d2345ed6225a5472637f100b10c36d9fe3feda7a28"
    end
  end

  def install
    bin.install "spogo"
  end

  test do
    assert_match "spogo", shell_output("#{bin}/spogo --help")
  end
end
