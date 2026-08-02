class Camsnap < Formula
  desc "One command to grab frames, clips, or motion alerts from RTSP/ONVIF cams"
  homepage "https://github.com/steipete/camsnap"
  version "0.3.0"
  license "MIT"

  depends_on "ffmpeg"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/steipete/camsnap/releases/download/v0.3.0/camsnap_0.3.0_darwin_arm64.tar.gz"
      sha256 "7c69199adc077c683d451e81a26fbb020e6bc9319bb215f3170d49281e9b93cd"
    else
      url "https://github.com/steipete/camsnap/releases/download/v0.3.0/camsnap_0.3.0_darwin_amd64.tar.gz"
      sha256 "a1a3abced39efd4663061bb5634613c06bbda93d055c5312266e20573e7d79dc"
    end
  end

  on_linux do
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/steipete/camsnap/releases/download/v0.3.0/camsnap_0.3.0_linux_arm64.tar.gz"
      sha256 "3d448199bda43e4f9be35b5c95c19691860216ab7e28b8b694fa46a30f5df36a"
    else
      url "https://github.com/steipete/camsnap/releases/download/v0.3.0/camsnap_0.3.0_linux_amd64.tar.gz"
      sha256 "0bfea0530b5ee62bb079e36026dcfe382cec5e0bfa0f8238490dbe8c5eb55d76"
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
