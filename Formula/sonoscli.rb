class Sonoscli < Formula
  desc "Control Sonos speakers from the command-line"
  homepage "https://github.com/steipete/sonoscli"
  version "0.3.6"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/steipete/sonoscli/releases/download/v0.3.6/sonoscli_0.3.6_darwin_arm64.tar.gz"
      sha256 "f0f3777d50d050f98c5cd25b44a839fbfeff0d4e173ff13c570f7b3564f0f50d"
    else
      url "https://github.com/steipete/sonoscli/releases/download/v0.3.6/sonoscli_0.3.6_darwin_amd64.tar.gz"
      sha256 "c3c5ef55dae93a4b86222d56a5f6c067afcb08c65405126a143bf3ff1d774d5c"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/steipete/sonoscli/releases/download/v0.3.6/sonoscli_0.3.6_linux_arm64.tar.gz"
      sha256 "2b419de3e7cacbf61576242464ab7ca2d594f5b7f2278f9c4d26a96a2f9b72ea"
    else
      url "https://github.com/steipete/sonoscli/releases/download/v0.3.6/sonoscli_0.3.6_linux_amd64.tar.gz"
      sha256 "8af3567397b37822cf3260cd4d79cfa9fdffad5cdcf4a963c7506a2f5a4910db"
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
