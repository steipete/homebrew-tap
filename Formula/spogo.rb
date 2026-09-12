class Spogo < Formula
  desc "Spotify power CLI using web cookies"
  homepage "https://github.com/openclaw/spogo"
  version "0.12.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/openclaw/spogo/releases/download/v0.12.0/spogo_0.12.0_darwin_arm64.tar.gz"
      sha256 "075decc3d4efd8ab831fd7de4f44a12c37ba7bd7dfdb76f23887e4061cfe2a24"
    else
      url "https://github.com/openclaw/spogo/releases/download/v0.12.0/spogo_0.12.0_darwin_amd64.tar.gz"
      sha256 "1f6625dfb0070044397c0a15e9b2a1048c829e504104df72672cd660f6fb6bc1"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/openclaw/spogo/releases/download/v0.12.0/spogo_0.12.0_linux_arm64.tar.gz"
      sha256 "7ef6f24d894786cdb11943c3964cd2558965d4369536e2efd9e42ca18f01dbe4"
    else
      url "https://github.com/openclaw/spogo/releases/download/v0.12.0/spogo_0.12.0_linux_amd64.tar.gz"
      sha256 "be431e3e5f7041d79d9022cd974f03ae4236edb201bad44e4a2d7172a7dbb10a"
    end
  end

  def install
    bin.install "spogo"
  end

  test do
    assert_match "spogo", shell_output("#{bin}/spogo --help")
  end
end
