class Spogo < Formula
  desc "Spotify power CLI using web cookies"
  homepage "https://github.com/openclaw/spogo"
  version "0.10.5"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/openclaw/spogo/releases/download/v0.10.5/spogo_0.10.5_darwin_arm64.tar.gz"
      sha256 "3db1e600946021a33ba4008c193ebeb6bbd5e203d1b836eedff5c354174cbf8c"
    else
      url "https://github.com/openclaw/spogo/releases/download/v0.10.5/spogo_0.10.5_darwin_amd64.tar.gz"
      sha256 "327bba3a8594a16ad72f245a8293899251ffbddb5dcfe90c40dd19baef162207"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/openclaw/spogo/releases/download/v0.10.5/spogo_0.10.5_linux_arm64.tar.gz"
      sha256 "cd0f8131d44a65bac8bce1081108571ad82dc5ccecfab1d3a171976488dc6edf"
    else
      url "https://github.com/openclaw/spogo/releases/download/v0.10.5/spogo_0.10.5_linux_amd64.tar.gz"
      sha256 "627b17c7dd44f2d0be4fd307a48ac325ff3a5335cf7b1db8433d54c06e59168f"
    end
  end

  def install
    bin.install "spogo"
  end

  test do
    assert_match "spogo", shell_output("#{bin}/spogo --help")
  end
end
