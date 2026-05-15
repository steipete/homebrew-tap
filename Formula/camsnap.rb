class Camsnap < Formula
  desc "One command to grab frames, clips, or motion alerts from RTSP/ONVIF cams"
  homepage "https://github.com/steipete/camsnap"
  version "0.2.1"
  license "MIT"

  depends_on "ffmpeg"

  on_macos do
    depends_on arch: :arm64

    on_arm do
      url "https://github.com/steipete/camsnap/releases/download/v0.2.1/camsnap_0.2.1_darwin_arm64.tar.gz"
      sha256 "180853d82be3459e3cf3b2fe68a5d726683889c6b035fba0b5c2571e9fbcf361"
    end
  end

  on_linux do
    depends_on "go" => :build

    on_intel do
      url "https://github.com/steipete/camsnap/archive/refs/tags/v0.2.1.tar.gz"
      sha256 "b79d03a76a07134725b2b73059b692eb868971bfd7b65200b72f37b14334d2ee"
    end

    on_arm do
      url "https://github.com/steipete/camsnap/archive/refs/tags/v0.2.1.tar.gz"
      sha256 "b79d03a76a07134725b2b73059b692eb868971bfd7b65200b72f37b14334d2ee"
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
