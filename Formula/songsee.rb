class Songsee < Formula
  desc "Spectral visualization CLI for audio files"
  homepage "https://github.com/steipete/songsee"
  url "https://github.com/steipete/songsee/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "a2d7eaed713940d526e113d11de8ba9e9dc91b25231a0a263b18493f32093f2d"
  license "MIT"

  depends_on "go" => :build

  def install
    ldflags = "-s -w -X main.version=v#{version}"
    system "go", "build", *std_go_args(output: bin/"songsee", ldflags:), "./cmd/songsee"
  end

  test do
    assert_match "v#{version}", shell_output("#{bin}/songsee --version")
  end
end
