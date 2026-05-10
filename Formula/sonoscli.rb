class Sonoscli < Formula
  desc "Control Sonos speakers from the command-line"
  homepage "https://github.com/steipete/sonoscli"
  url "https://github.com/steipete/sonoscli/releases/download/v0.3.1/sonoscli_0.3.1_darwin_arm64.tar.gz"
  version "0.3.1"
  sha256 "e8da3e5633e9456344ef049258b08c70feaaa73749ff35ff484075ea7b1cdcc8"
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
