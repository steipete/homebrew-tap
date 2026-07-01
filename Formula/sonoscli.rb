class Sonoscli < Formula
  desc "Control Sonos speakers from the command-line"
  homepage "https://github.com/steipete/sonoscli"
  url "https://github.com/steipete/sonoscli/releases/download/v0.3.3/sonoscli_0.3.3_macos-universal.tar.gz"
  sha256 "ee02eccb43f6cd821322da461bedaa8f0ffad625068b8f41e7e957a9dd9ade6a"
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
