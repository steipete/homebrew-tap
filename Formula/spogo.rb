class Spogo < Formula
  desc "Spotify power CLI using web cookies"
  homepage "https://github.com/steipete/spogo"
  version "0.1.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/steipete/spogo/releases/download/v#{version}/spogo_#{version}_darwin_arm64.tar.gz"
      sha256 "d9bcccf83abe02f34f907ff2d1cdadf25d4bec8a269bf51fe1c4bcd87580329e"
    else
      url "https://github.com/steipete/spogo/releases/download/v#{version}/spogo_#{version}_darwin_amd64.tar.gz"
      sha256 "048a5714ef90ef8a716d2bdb77fa9f654432d023d5a06508754e34084ebb4db3"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/steipete/spogo/releases/download/v#{version}/spogo_#{version}_linux_arm64.tar.gz"
      sha256 "62bcbfb7620b0e6c6d9bf0399c67a378d5e589652acee9f648c1fd2f8bc6795c"
    else
      url "https://github.com/steipete/spogo/releases/download/v#{version}/spogo_#{version}_linux_amd64.tar.gz"
      sha256 "ad57d47458277a98ea0c98a00e7a983eb86e83f061d56a12aa40bc6991e169db"
    end
  end

  def install
    bin.install "spogo"
  end

  test do
    assert_match "spogo", shell_output("#{bin}/spogo --help")
  end
end
