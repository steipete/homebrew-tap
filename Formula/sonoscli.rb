class Sonoscli < Formula
  desc "Control Sonos speakers from the command-line"
  homepage "https://github.com/steipete/sonoscli"
  url "https://github.com/steipete/sonoscli/releases/download/v0.2.0/sonoscli_0.2.0_darwin_arm64.tar.gz"
  version "0.2.0"
  sha256 "697997967c07770f7569c3f437a34cb0ffb974a6252e3f45c017b132d1e3b149"
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
