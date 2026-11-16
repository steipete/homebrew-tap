class Camsnap < Formula
  desc "One command to grab frames, clips, or motion alerts from RTSP/ONVIF cams"
  homepage "https://github.com/steipete/camsnap"
  version "0.6.3"
  license "MIT"

  depends_on "ffmpeg"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/steipete/camsnap/releases/download/v0.6.3/camsnap_0.6.3_darwin_arm64.tar.gz"
      sha256 "fdbf0112071d83ca2e47df76f9a2c4ae1015cea3096694813210210e1efc6d13"
    else
      url "https://github.com/steipete/camsnap/releases/download/v0.6.3/camsnap_0.6.3_darwin_amd64.tar.gz"
      sha256 "96c3d3d2c0d21be4e4715ccf83594b9012ca2576fdc8677f660b35aed04c6cec"
    end
  end

  on_linux do
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/steipete/camsnap/releases/download/v0.6.3/camsnap_0.6.3_linux_arm64.tar.gz"
      sha256 "8d6010b9cdc4c06884957c6201d47a218d15b8fb5cc03cc4337a11b1ea4adda4"
    else
      url "https://github.com/steipete/camsnap/releases/download/v0.6.3/camsnap_0.6.3_linux_amd64.tar.gz"
      sha256 "a3f28946d1e9a08b1e0a63ff6cfb6b86b87479db66ee3bfe1a2f43f200cccc86"
    end
  end

  def install
    bin.install "camsnap"
    prefix.install "LICENSE"
    prefix.install "README.md"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/camsnap --version")
  end
end
