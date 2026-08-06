class Camsnap < Formula
  desc "One command to grab frames, clips, or motion alerts from RTSP/ONVIF cams"
  homepage "https://github.com/steipete/camsnap"
  version "0.4.0"
  license "MIT"

  depends_on "ffmpeg"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/steipete/camsnap/releases/download/v0.4.0/camsnap_0.4.0_darwin_arm64.tar.gz"
      sha256 "e6550887d4b1e22f32a35c8c1b2f969e01f272288721b49b54b7b37eb547d58f"
    else
      url "https://github.com/steipete/camsnap/releases/download/v0.4.0/camsnap_0.4.0_darwin_amd64.tar.gz"
      sha256 "7c565380703e96c34d273c40dd3df309f1a4f6aac51c0b42754d5693e80577c1"
    end
  end

  on_linux do
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/steipete/camsnap/releases/download/v0.4.0/camsnap_0.4.0_linux_arm64.tar.gz"
      sha256 "42913e31027e3628220556bb7e01d05dcfe5de37b40a910f42dfa25a8adf4888"
    else
      url "https://github.com/steipete/camsnap/releases/download/v0.4.0/camsnap_0.4.0_linux_amd64.tar.gz"
      sha256 "ab8ede213338220afae10e2fc608cf8326d0b8fe0dcb0a23ad32dc228f390e1f"
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
