class Songsee < Formula
  desc "Spectral visualization CLI for audio files"
  homepage "https://github.com/openclaw/songsee"
  url "https://github.com/openclaw/songsee/archive/refs/tags/v0.1.3.tar.gz"
  sha256 "3a74bda3f65ea787c4fca4dcf4dc35493157b019ed638161c7b24217ad3a5abb"
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
