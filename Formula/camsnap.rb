class Camsnap < Formula
  desc "One command to grab frames, clips, or motion alerts from RTSP/ONVIF cams"
  homepage "https://github.com/steipete/camsnap"
  version "0.5.2"
  license "MIT"

  depends_on "ffmpeg"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/steipete/camsnap/releases/download/v0.5.2/camsnap_0.5.2_darwin_arm64.tar.gz"
      sha256 "7989c97850f19afab2ac4cd221d4b49471e9fce34105ff9f26f8dadaf588054f"
    else
      url "https://github.com/steipete/camsnap/releases/download/v0.5.2/camsnap_0.5.2_darwin_amd64.tar.gz"
      sha256 "904f7dce4883a0873d73bb5425a43dde82535d37a4636ff7fab33bcaabde2e44"
    end
  end

  on_linux do
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/steipete/camsnap/releases/download/v0.5.2/camsnap_0.5.2_linux_arm64.tar.gz"
      sha256 "42d4a3f31a166ed1db757ab670277bca1027ae5fa6e2b02ffffb044b5afab14e"
    else
      url "https://github.com/steipete/camsnap/releases/download/v0.5.2/camsnap_0.5.2_linux_amd64.tar.gz"
      sha256 "79a12e6a546e1fc46958225e6f27f82f9954038fbb2e26e7cc0a3b02c4522237"
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
