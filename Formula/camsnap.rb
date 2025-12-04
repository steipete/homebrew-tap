class Camsnap < Formula
  desc "One command to grab frames, clips, or motion alerts from RTSP/ONVIF cams"
  homepage "https://github.com/steipete/camsnap"
  url "https://github.com/steipete/camsnap.git",
      tag: "v0.2.0",
      revision: "141ca9f83b8a6ae9e8fb9a40c2a1dc040bfee1c8"
  license "MIT"

  depends_on "go" => :build
  depends_on "ffmpeg"

  def install
    ldflags = "-s -w -X main.version=#{version}"
    system "go", "build", *std_go_args(ldflags:, output: bin/"camsnap"), "./cmd/camsnap"
  end

  test do
    assert_match version, shell_output("#{bin}/camsnap --version")
  end
end
