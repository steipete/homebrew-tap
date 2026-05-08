class Sonoscli < Formula
  desc "Control Sonos speakers from the command-line"
  homepage "https://github.com/steipete/sonoscli"
  url "https://github.com/steipete/sonoscli/releases/download/v0.3.0/sonoscli_0.3.0_darwin_arm64.tar.gz"
  version "0.3.0"
  sha256 "c4054095d7e1e11d31c86b0498daee05f202485724bf8e33ef67c4b218d3c493"
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
