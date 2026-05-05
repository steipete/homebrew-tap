class Spogo < Formula
  desc "Spotify power CLI using web cookies"
  homepage "https://github.com/steipete/spogo"
  version "0.3.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/steipete/spogo/releases/download/v#{version}/spogo_#{version}_darwin_arm64.tar.gz"
      sha256 "31347589b270d44522eef1ebb7cb017f20553280661bd857407a433068e17a37"
    else
      url "https://github.com/steipete/spogo/releases/download/v#{version}/spogo_#{version}_darwin_amd64.tar.gz"
      sha256 "7cd989b5656d1c0b8151a856f7a282c94524454d2eba5081fc328bd2bed7faaa"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/steipete/spogo/releases/download/v#{version}/spogo_#{version}_linux_arm64.tar.gz"
      sha256 "a8ddc30c071d7d1ed53457a40cdfa401aa31a1fc55c2f7976ad75918c5e28197"
    else
      url "https://github.com/steipete/spogo/releases/download/v#{version}/spogo_#{version}_linux_amd64.tar.gz"
      sha256 "aa22053b33d322d7d35fc7bc6bc1268f926a076468cadd6265344062d05a1f84"
    end
  end

  def install
    bin.install "spogo"
  end

  test do
    assert_match "spogo", shell_output("#{bin}/spogo --help")
  end
end
