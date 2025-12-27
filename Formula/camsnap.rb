class Camsnap < Formula
  desc "One command to grab frames, clips, or motion alerts from RTSP/ONVIF cams"
  homepage "https://github.com/steipete/camsnap"
  url "https://github.com/steipete/camsnap/releases/download/v0.2.0/camsnap-macos-arm64.tar.gz"
  version "0.2.0"
  sha256 "61282790df47b923db602d22a11f796e59147dc1c4c9ee9a4125bb96a2b3833e"
  license "MIT"

  depends_on arch: :arm64
  depends_on "ffmpeg"

  def install
    bin.install Dir["**/camsnap"].first
    prefix.install Dir["**/LICENSE"].first => "LICENSE"
    prefix.install Dir["**/README.md"].first => "README.md"
  end

  test do
    assert_match version, shell_output("#{bin}/camsnap --version")
  end
end
