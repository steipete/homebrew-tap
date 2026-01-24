class Spogo < Formula
  desc "Spotify power CLI using web cookies"
  homepage "https://github.com/steipete/spogo"
  version "0.2.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/steipete/spogo/releases/download/v#{version}/spogo_#{version}_darwin_arm64.tar.gz"
      sha256 "4ff7edd6c820c8c444d5a9190825366af47210190073f000d7817e666eada32b"
    else
      url "https://github.com/steipete/spogo/releases/download/v#{version}/spogo_#{version}_darwin_amd64.tar.gz"
      sha256 "4078c4150c50e15d529ee184568ebc98da160bf3ea34f9d6aa29d9ff17da5634"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/steipete/spogo/releases/download/v#{version}/spogo_#{version}_linux_arm64.tar.gz"
      sha256 "7c48e7a70cc69a6b5e5d29eba559e235e15f39499d87b0bf7bcebf47cb705a5f"
    else
      url "https://github.com/steipete/spogo/releases/download/v#{version}/spogo_#{version}_linux_amd64.tar.gz"
      sha256 "5e57e0869858b6b4fe36d8553ccee4424685ef84f1ad5e9fc771086f2ffe9947"
    end
  end

  def install
    bin.install "spogo"
  end

  test do
    assert_match "spogo", shell_output("#{bin}/spogo --help")
  end
end
