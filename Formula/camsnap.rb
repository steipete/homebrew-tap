class Camsnap < Formula
  desc "One command to grab frames, clips, or motion alerts from RTSP/ONVIF cams"
  homepage "https://github.com/steipete/camsnap"
  version "0.2.1"
  license "MIT"

  depends_on "ffmpeg"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/steipete/camsnap/releases/download/v0.2.1/camsnap_0.2.1_darwin_arm64.tar.gz"
      sha256 "180853d82be3459e3cf3b2fe68a5d726683889c6b035fba0b5c2571e9fbcf361"
    else
      url "https://github.com/steipete/camsnap/releases/download/v0.2.1/camsnap_0.2.1_darwin_amd64.tar.gz"
      sha256 "8c02704f4d30de34072232de3f49bdcc4bc979fdaba2e51ffc971ac6153bd7a2"
    end
  end

  on_linux do
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/steipete/camsnap/releases/download/v0.2.1/camsnap_0.2.1_linux_arm64.tar.gz"
      sha256 "4fa59eced92288db41946a6205db89ce96b5f2f78434963cedcaaf77fe4c1f88"
    else
      url "https://github.com/steipete/camsnap/releases/download/v0.2.1/camsnap_0.2.1_linux_amd64.tar.gz"
      sha256 "be20e49a759d38dfac34218107a6a1dd99482744ef0b0bb2d8fba86468bfd982"
    end
  end

  def install
    bin.install "camsnap"
    prefix.install "LICENSE"
    prefix.install "README.md"
  end

  test do
    assert_match version, shell_output("#{bin}/camsnap --version")
  end
end
