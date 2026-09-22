class Camsnap < Formula
  desc "One command to grab frames, clips, or motion alerts from RTSP/ONVIF cams"
  homepage "https://github.com/steipete/camsnap"
  version "0.5.1"
  license "MIT"

  depends_on "ffmpeg"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/steipete/camsnap/releases/download/v0.5.1/camsnap_0.5.1_darwin_arm64.tar.gz"
      sha256 "4716af63f05cd4ff3f5fe5a54df37a9bb85736a3dbda9914a45f521912d70d5f"
    else
      url "https://github.com/steipete/camsnap/releases/download/v0.5.1/camsnap_0.5.1_darwin_amd64.tar.gz"
      sha256 "9ee93486d9358e9b3735b5c3db9fe0cb4778b6678c1dff629fbd27275ff4cf03"
    end
  end

  on_linux do
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/steipete/camsnap/releases/download/v0.5.1/camsnap_0.5.1_linux_arm64.tar.gz"
      sha256 "6e1d1cc0a4373fc4a3e15d0ea5befdcba5005af7c4c3d56f868a623baef0136f"
    else
      url "https://github.com/steipete/camsnap/releases/download/v0.5.1/camsnap_0.5.1_linux_amd64.tar.gz"
      sha256 "a50c2064d95fe649432cc1a6ae78e3bbf8558eb34f061557df700d471727ebb1"
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
