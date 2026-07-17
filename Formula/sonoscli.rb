class Sonoscli < Formula
  desc "Control Sonos speakers from the command-line"
  homepage "https://github.com/steipete/sonoscli"
  url "https://github.com/steipete/sonoscli/releases/download/v0.3.4/sonoscli_0.3.4_macos-universal.tar.gz"
  sha256 "14188372024cdb5855514418862bee1efdd4f5716c2b6721e2b4018b415af83a"
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
