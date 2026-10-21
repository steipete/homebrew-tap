class Camsnap < Formula
  desc "One command to grab frames, clips, or motion alerts from RTSP/ONVIF cams"
  homepage "https://github.com/steipete/camsnap"
  version "0.6.1"
  license "MIT"

  depends_on "ffmpeg"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/steipete/camsnap/releases/download/v0.6.1/camsnap_0.6.1_darwin_arm64.tar.gz"
      sha256 "273bff3d5ef0749e68742307c58724dc5e109b80c1c97cdd408e39aaa3d77dbd"
    else
      url "https://github.com/steipete/camsnap/releases/download/v0.6.1/camsnap_0.6.1_darwin_amd64.tar.gz"
      sha256 "b3b3b0f576e68239c7665760483fa9830d5c55ec73a308fd633b3157687ab4f2"
    end
  end

  on_linux do
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/steipete/camsnap/releases/download/v0.6.1/camsnap_0.6.1_linux_arm64.tar.gz"
      sha256 "c39778d40bcb4a60141a1973e0260a24088e08bea89b09589ef0ee5618f95085"
    else
      url "https://github.com/steipete/camsnap/releases/download/v0.6.1/camsnap_0.6.1_linux_amd64.tar.gz"
      sha256 "57b9b85ec4575021e401f94fe9c54d669b7fdd2f92b8a744cebe9f5307977a7c"
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
