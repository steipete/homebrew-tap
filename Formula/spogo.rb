class Spogo < Formula
  desc "Spotify power CLI using web cookies"
  homepage "https://github.com/openclaw/spogo"
  version "0.10.8"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/openclaw/spogo/releases/download/v0.10.8/spogo_0.10.8_darwin_arm64.tar.gz"
      sha256 "4c11bed8aa7721f1e0ad9a54487fe61838aa4ae16390e7b5ecf4d081b39b97e7"
    else
      url "https://github.com/openclaw/spogo/releases/download/v0.10.8/spogo_0.10.8_darwin_amd64.tar.gz"
      sha256 "a63969564abe9d960d46008a38aa8ec7a3afb0fb20fb58235d05e870081bbf99"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/openclaw/spogo/releases/download/v0.10.8/spogo_0.10.8_linux_arm64.tar.gz"
      sha256 "7e82e8daf250e64a58012eabf014e96e6e8e5b7ef52b4f146e015f66780c0f9b"
    else
      url "https://github.com/openclaw/spogo/releases/download/v0.10.8/spogo_0.10.8_linux_amd64.tar.gz"
      sha256 "c6e4484e6b4ad091dd328fd01f473b21d4687f15bf3b3223e50ff35a4046d039"
    end
  end

  def install
    bin.install "spogo"
  end

  test do
    assert_match "spogo", shell_output("#{bin}/spogo --help")
  end
end
