class Spogo < Formula
  desc "Spotify power CLI using web cookies"
  homepage "https://github.com/openclaw/spogo"
  version "0.10.1"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/openclaw/spogo/releases/download/v0.10.1/spogo_0.10.1_darwin_arm64.tar.gz"
      sha256 "bcc225e4b42b4e5801bdb2668c7023c2e51d7dd85eca36d1080c36aec278507b"
    else
      url "https://github.com/openclaw/spogo/releases/download/v0.10.1/spogo_0.10.1_darwin_amd64.tar.gz"
      sha256 "53b6be98d8206584c2920eddfde54f5d55f65ea200e694f6789c67080939dd41"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/openclaw/spogo/releases/download/v0.10.1/spogo_0.10.1_linux_arm64.tar.gz"
      sha256 "2c8d3db4a6bea08fa71202b327779799484fa9a85e4218ecf3d67ee566c6153b"
    else
      url "https://github.com/openclaw/spogo/releases/download/v0.10.1/spogo_0.10.1_linux_amd64.tar.gz"
      sha256 "40f5028ebd0eb226cc7dff5bdfb3f7ccfeb5113b09d300838d92eaf4053e0f28"
    end
  end

  def install
    bin.install "spogo"
  end

  test do
    assert_match "spogo", shell_output("#{bin}/spogo --help")
  end
end
