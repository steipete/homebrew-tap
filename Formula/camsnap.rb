class Camsnap < Formula
  desc "One command to grab frames, clips, or motion alerts from RTSP/ONVIF cams"
  homepage "https://github.com/steipete/camsnap"
  version "0.6.0"
  license "MIT"

  depends_on "ffmpeg"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/steipete/camsnap/releases/download/v0.6.0/camsnap_0.6.0_darwin_arm64.tar.gz"
      sha256 "12fb07754444ca5baa90050dc06c23de562fb88550de2689999c857e6b8280da"
    else
      url "https://github.com/steipete/camsnap/releases/download/v0.6.0/camsnap_0.6.0_darwin_amd64.tar.gz"
      sha256 "c358be5ccdd633e8f446c9fb869fc34818d97fcdfd18e431c2e0d59902ac300d"
    end
  end

  on_linux do
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/steipete/camsnap/releases/download/v0.6.0/camsnap_0.6.0_linux_arm64.tar.gz"
      sha256 "96b112bd1b657b2f32af7a09146883dc2b985eadfada28165cff2f75e3322543"
    else
      url "https://github.com/steipete/camsnap/releases/download/v0.6.0/camsnap_0.6.0_linux_amd64.tar.gz"
      sha256 "98cd574b30bfbf3b15a8b50556e56d8422c29d616ebb37fbf3222cca8a369f42"
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
