class Camsnap < Formula
  desc "One command to grab frames, clips, or motion alerts from RTSP/ONVIF cams"
  homepage "https://github.com/steipete/camsnap"
  version "0.4.1"
  license "MIT"

  depends_on "ffmpeg"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/steipete/camsnap/releases/download/v0.4.1/camsnap_0.4.1_darwin_arm64.tar.gz"
      sha256 "9e343801770e4a08eab7ee4caddd3d11329bd3e36149fd5caa6ce36fd6876463"
    else
      url "https://github.com/steipete/camsnap/releases/download/v0.4.1/camsnap_0.4.1_darwin_amd64.tar.gz"
      sha256 "a7684c97efbe0a38adc24380998a6dbf5d2d89baf389354f34a309d1b46103e3"
    end
  end

  on_linux do
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/steipete/camsnap/releases/download/v0.4.1/camsnap_0.4.1_linux_arm64.tar.gz"
      sha256 "105b00b327cb2f2215a84197600a491fff5531d927d28bd88cbf3bf5ffed5884"
    else
      url "https://github.com/steipete/camsnap/releases/download/v0.4.1/camsnap_0.4.1_linux_amd64.tar.gz"
      sha256 "c459dc78dd88b8bd09f62f346b8a007668b59220420c61f6e66e585434fde64c"
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
