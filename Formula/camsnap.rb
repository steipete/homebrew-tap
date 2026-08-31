class Camsnap < Formula
  desc "One command to grab frames, clips, or motion alerts from RTSP/ONVIF cams"
  homepage "https://github.com/steipete/camsnap"
  version "0.5.0"
  license "MIT"

  depends_on "ffmpeg"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/steipete/camsnap/releases/download/v0.5.0/camsnap_0.5.0_darwin_arm64.tar.gz"
      sha256 "49fe6ec4627963635efa21d33c348216032e6ec522c996b11421e322d132db47"
    else
      url "https://github.com/steipete/camsnap/releases/download/v0.5.0/camsnap_0.5.0_darwin_amd64.tar.gz"
      sha256 "de09ee7a2683b3e6d0b1f1b8861e3e250be7145995402977381a10d5a17d422f"
    end
  end

  on_linux do
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/steipete/camsnap/releases/download/v0.5.0/camsnap_0.5.0_linux_arm64.tar.gz"
      sha256 "58e64a1faa14d38c6cbb26c1cb53de21ea103c1410be4abf484d0bb5dc6f7791"
    else
      url "https://github.com/steipete/camsnap/releases/download/v0.5.0/camsnap_0.5.0_linux_amd64.tar.gz"
      sha256 "f39b2db6288c7f05287fcc493848bb1cd7cc297210467bf05aaa9c689bea79b5"
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
