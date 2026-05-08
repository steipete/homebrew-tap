class Camsnap < Formula
  desc "One command to grab frames, clips, or motion alerts from RTSP/ONVIF cams"
  homepage "https://github.com/steipete/camsnap"
  version "0.2.0"
  license "MIT"

  depends_on "ffmpeg"

  on_macos do
    depends_on arch: :arm64

    on_arm do
      url "https://github.com/steipete/camsnap/releases/download/v0.2.0/camsnap-macos-arm64.tar.gz"
      sha256 "61282790df47b923db602d22a11f796e59147dc1c4c9ee9a4125bb96a2b3833e"
    end
  end

  on_linux do
    depends_on "go" => :build

    on_intel do
      url "https://github.com/steipete/camsnap/archive/refs/tags/v0.2.0.tar.gz"
      sha256 "9983c298f1afe1c01a431e2acb287b5522f42e65195c244478e2a0041828df77"
    end

    on_arm do
      url "https://github.com/steipete/camsnap/archive/refs/tags/v0.2.0.tar.gz"
      sha256 "9983c298f1afe1c01a431e2acb287b5522f42e65195c244478e2a0041828df77"
    end
  end

  def install
    if File.exist?("camsnap")
      bin.install "camsnap"
    else
      system "go", "build", *std_go_args(ldflags: "-s -w -X main.version=#{version}"), "./cmd/camsnap"
    end

    prefix.install "LICENSE"
    prefix.install "README.md"
  end

  test do
    assert_match version, shell_output("#{bin}/camsnap --version")
  end
end
