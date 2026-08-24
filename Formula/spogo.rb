class Spogo < Formula
  desc "Spotify power CLI using web cookies"
  homepage "https://github.com/openclaw/spogo"
  version "0.10.7"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/openclaw/spogo/releases/download/v0.10.7/spogo_0.10.7_darwin_arm64.tar.gz"
      sha256 "2ff68d8dccd9fcea5ebf72ff84c4ce8df66f6103e4dc1117b89a2f440bbeaa4d"
    else
      url "https://github.com/openclaw/spogo/releases/download/v0.10.7/spogo_0.10.7_darwin_amd64.tar.gz"
      sha256 "e2fccf588b90b967f33f23aa74a3bf4b6fc25ce67116d00e363f0d407c6159d9"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/openclaw/spogo/releases/download/v0.10.7/spogo_0.10.7_linux_arm64.tar.gz"
      sha256 "9e944cda2bbaced63fad32f686c29f6db4ca3afe430cb3a842a5fb82f50edaa4"
    else
      url "https://github.com/openclaw/spogo/releases/download/v0.10.7/spogo_0.10.7_linux_amd64.tar.gz"
      sha256 "f0177aa7dd3a531bbaa11f71846b9407ad5d730ea5747b94ab63a60e20a84c93"
    end
  end

  def install
    bin.install "spogo"
  end

  test do
    assert_match "spogo", shell_output("#{bin}/spogo --help")
  end
end
