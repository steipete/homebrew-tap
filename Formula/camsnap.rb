class Camsnap < Formula
  desc "One command to grab frames, clips, or motion alerts from RTSP/ONVIF cams"
  homepage "https://github.com/steipete/camsnap"
  version "0.6.2"
  license "MIT"

  depends_on "ffmpeg"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/steipete/camsnap/releases/download/v0.6.2/camsnap_0.6.2_darwin_arm64.tar.gz"
      sha256 "a3170a14682c75609413de92e12aedf31b9ef3049a5d379ea5687f93de418e60"
    else
      url "https://github.com/steipete/camsnap/releases/download/v0.6.2/camsnap_0.6.2_darwin_amd64.tar.gz"
      sha256 "4db2cce743d12c7869c8988cb72a90c97c4864f967486b4b76ff3aceb520ab9e"
    end
  end

  on_linux do
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/steipete/camsnap/releases/download/v0.6.2/camsnap_0.6.2_linux_arm64.tar.gz"
      sha256 "1d2f46457256ad4d8306628b5ffb9a82bc4e39f25c9dc6001394d7d80ba725ba"
    else
      url "https://github.com/steipete/camsnap/releases/download/v0.6.2/camsnap_0.6.2_linux_amd64.tar.gz"
      sha256 "2c711d8654159b85b3c1ec37c4305b795a5c6f5c3e2142f8a99ca30816dcb35d"
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
