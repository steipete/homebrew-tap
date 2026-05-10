class Spogo < Formula
  desc "Spotify power CLI using web cookies"
  homepage "https://github.com/openclaw/spogo"
  version "0.3.1"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/openclaw/spogo/releases/download/v0.3.1/spogo_0.3.1_darwin_arm64.tar.gz"
      sha256 "f241a15b1f6d254c9d01c3861b66864875ce21e325cef6ea91a71f54422e7fe7"
    else
      url "https://github.com/openclaw/spogo/releases/download/v0.3.1/spogo_0.3.1_darwin_amd64.tar.gz"
      sha256 "51409563e50273a4c4f79be29ab0f7cca7e054075e0d3cd4395d6f926208d7c7"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/openclaw/spogo/releases/download/v0.3.1/spogo_0.3.1_linux_arm64.tar.gz"
      sha256 "4c56cfce725f74b8e8f4fdd6063bc4bdd5789feb4c40de7934dc506014d255a1"
    else
      url "https://github.com/openclaw/spogo/releases/download/v0.3.1/spogo_0.3.1_linux_amd64.tar.gz"
      sha256 "0452bfe3e91d1f6bef500704892353f5b5fbd9b87669589e6db4e8af6819aceb"
    end
  end

  def install
    bin.install "spogo"
  end

  test do
    assert_match "spogo", shell_output("#{bin}/spogo --help")
  end
end
