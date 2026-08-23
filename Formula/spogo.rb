class Spogo < Formula
  desc "Spotify power CLI using web cookies"
  homepage "https://github.com/openclaw/spogo"
  version "0.10.6"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/openclaw/spogo/releases/download/v0.10.6/spogo_0.10.6_darwin_arm64.tar.gz"
      sha256 "9409dbe727b2f10008c46095b81ea74c57807b7f2a2e1a735b3f96a7e3843abb"
    else
      url "https://github.com/openclaw/spogo/releases/download/v0.10.6/spogo_0.10.6_darwin_amd64.tar.gz"
      sha256 "2be5b0867999fdde88076d9870b35d7d2594af462678bd50e2f60562ddf4dcd0"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/openclaw/spogo/releases/download/v0.10.6/spogo_0.10.6_linux_arm64.tar.gz"
      sha256 "fd3fba584852c7418b8bf3dbd40c79c44bf91c5e05b55f9ac058ac44e1d614c8"
    else
      url "https://github.com/openclaw/spogo/releases/download/v0.10.6/spogo_0.10.6_linux_amd64.tar.gz"
      sha256 "941449c219d5c149fda5c060d2c0848b4da873e3568ef95736131d7048dcab82"
    end
  end

  def install
    bin.install "spogo"
  end

  test do
    assert_match "spogo", shell_output("#{bin}/spogo --help")
  end
end
