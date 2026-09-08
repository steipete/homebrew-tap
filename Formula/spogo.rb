class Spogo < Formula
  desc "Spotify power CLI using web cookies"
  homepage "https://github.com/openclaw/spogo"
  version "0.11.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/openclaw/spogo/releases/download/v0.11.0/spogo_0.11.0_darwin_arm64.tar.gz"
      sha256 "f94af7fd623facceb50947f860bdd620ada388967c607f079370147ba62fbdd2"
    else
      url "https://github.com/openclaw/spogo/releases/download/v0.11.0/spogo_0.11.0_darwin_amd64.tar.gz"
      sha256 "a66d13ecd6591daed67b869a1133ea128609d87fe053ee20d2eeabe3934732ed"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/openclaw/spogo/releases/download/v0.11.0/spogo_0.11.0_linux_arm64.tar.gz"
      sha256 "b77a6c4d91badf3c84feba9c7bf827aa4fb1f84bb703ed35274e5cc345e5bf1f"
    else
      url "https://github.com/openclaw/spogo/releases/download/v0.11.0/spogo_0.11.0_linux_amd64.tar.gz"
      sha256 "6d8491505085c82efab90fc989ea332d15b43a6a8becfadfe9509e7dad25ce46"
    end
  end

  def install
    bin.install "spogo"
  end

  test do
    assert_match "spogo", shell_output("#{bin}/spogo --help")
  end
end
