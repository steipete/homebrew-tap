class Sonoscli < Formula
  desc "Control Sonos speakers from the command-line"
  homepage "https://github.com/steipete/sonoscli"
  version "0.3.5"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/steipete/sonoscli/releases/download/v0.3.5/sonoscli_0.3.5_darwin_arm64.tar.gz"
      sha256 "11c582ec4dced2c4d5399c6cc4e96bed423ddc04e85863b0e1d59de5448580b2"
    else
      url "https://github.com/steipete/sonoscli/releases/download/v0.3.5/sonoscli_0.3.5_darwin_amd64.tar.gz"
      sha256 "654df80d841944e4ae44d2b53c745bf9476d3ff61988f4cef4612af8edd5785c"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/steipete/sonoscli/releases/download/v0.3.5/sonoscli_0.3.5_linux_arm64.tar.gz"
      sha256 "36c58de480f068ddbcbb80da69b42e5d44477a3c764f2ed21f16850b8e659ef0"
    else
      url "https://github.com/steipete/sonoscli/releases/download/v0.3.5/sonoscli_0.3.5_linux_amd64.tar.gz"
      sha256 "b2eba6f134b9b38f007878f67b85cdc2048fdced37c7812cea29dc5735e7c566"
    end
  end

  skip_clean "bin/sonos"

  def install
    bin.install "sonos"
  end

  test do
    assert_match "sonos #{version}", shell_output("#{bin}/sonos --version")
  end
end
