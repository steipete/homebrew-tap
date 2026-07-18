class Spogo < Formula
  desc "Spotify power CLI using web cookies"
  homepage "https://github.com/openclaw/spogo"
  version "0.10.3"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/openclaw/spogo/releases/download/v0.10.3/spogo_0.10.3_spogo_darwin_darwin_arm64_v8.0.tar.gz"
      sha256 "a05849c032fc46781680f4ff42357b4f7c34a5324cb5a0cc2246873e391b554d"
    else
      url "https://github.com/openclaw/spogo/releases/download/v0.10.3/spogo_0.10.3_spogo_darwin_darwin_amd64_v1.tar.gz"
      sha256 "7a2b5429ebf66a469409c3ef447fca08c67c21f0bd29dc0f0d9dc44dd13231b4"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/openclaw/spogo/releases/download/v0.10.3/spogo_0.10.3_spogo_linux_arm64_v8.0.tar.gz"
      sha256 "78352c3949066e120be2b0ecf29eda010f2c055e84a7211b71d63edc3dc1779e"
    else
      url "https://github.com/openclaw/spogo/releases/download/v0.10.3/spogo_0.10.3_spogo_linux_amd64_v1.tar.gz"
      sha256 "b4145fb3ee047c4bf756056daae984715a51b0674fb7d012387060f1ba2777a6"
    end
  end

  def install
    bin.install "spogo"
  end

  test do
    assert_match "spogo", shell_output("#{bin}/spogo --help")
  end
end
