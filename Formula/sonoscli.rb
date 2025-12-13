class Sonoscli < Formula
  desc "Control Sonos speakers from the command line"
  homepage "https://github.com/steipete/sonoscli"
  url "https://github.com/steipete/sonoscli/releases/download/v0.1.0/sonoscli-macos-arm64.tar.gz"
  sha256 "b795545973ebc60617a2989012e3bb93dd46c7bd2879fca16ce66617f5c3c1ac"
  version "0.1.0"
  license "MIT"

  depends_on arch: :arm64

  def install
    bin.install Dir["**/sonos"].first => "sonos"
    prefix.install Dir["**/LICENSE"].first => "LICENSE"
    prefix.install Dir["**/README.md"].first => "README.md"
  end

  test do
    assert_match "sonos #{version}", shell_output("#{bin}/sonos --version")
  end
end

