class Camsnap < Formula
  desc "One command to grab frames, clips, or motion alerts from RTSP/ONVIF cams"
  homepage "https://github.com/steipete/camsnap"
  version "0.2.2"
  license "MIT"

  depends_on "ffmpeg"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/steipete/camsnap/releases/download/v0.2.2/camsnap_0.2.2_darwin_arm64.tar.gz"
      sha256 "7b6b9730d2e77ccecb50c690bbdd571de2988ddacde19d31f6422b9d83cfd5e6"
    else
      url "https://github.com/steipete/camsnap/releases/download/v0.2.2/camsnap_0.2.2_darwin_amd64.tar.gz"
      sha256 "cd7ae60eacd76a013a9afabf02cdd069f8c311e88a6a76efa005939b5a1c4269"
    end
  end

  on_linux do
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/steipete/camsnap/releases/download/v0.2.2/camsnap_0.2.2_linux_arm64.tar.gz"
      sha256 "accc05bf6c6a284e46e614a03ac33cb6445bbd8dc99bdc4d1e7b253757d4a119"
    else
      url "https://github.com/steipete/camsnap/releases/download/v0.2.2/camsnap_0.2.2_linux_amd64.tar.gz"
      sha256 "9fb7ff7f0d937bed943af409f135b745f67de50e7038a2d488c6e40d6c2d6c69"
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
