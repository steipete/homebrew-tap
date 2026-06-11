class Sonoscli < Formula
  desc "Control Sonos speakers from the command-line"
  homepage "https://github.com/steipete/sonoscli"
  url "https://github.com/steipete/sonoscli/releases/download/v0.3.2/sonoscli_0.3.2_macos-universal.tar.gz"
  sha256 "33817232436e6248e297239aa44c69d281b1adcd4b3fa0633b3426f0381ad971"
  license "MIT"

  depends_on :macos
  def install
    bin.install Dir["**/sonos"].first => "sonos"
    prefix.install Dir["**/LICENSE"].first => "LICENSE"
    prefix.install Dir["**/README.md"].first => "README.md"
  end

  test do
    assert_match "sonos #{version}", shell_output("#{bin}/sonos --version")
  end
end
