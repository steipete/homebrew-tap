class Sonoscli < Formula
  desc "Control Sonos speakers from the command-line"
  homepage "https://github.com/steipete/sonoscli"
  url "https://github.com/steipete/sonoscli/releases/download/v0.3.2/sonoscli_0.3.2_macos-universal.tar.gz"
  version "0.3.2"
  sha256 "0750beae4f85dc47e3391601fae7f9a83d1aedb91a514e3fec4b72479fa071f6"
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
