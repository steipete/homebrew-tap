class Songsee < Formula
  desc "Spectral visualization CLI for audio files"
  homepage "https://github.com/openclaw/songsee"
  url "https://github.com/openclaw/songsee/archive/refs/tags/v0.1.2.tar.gz"
  sha256 "b70ca458eb3ead2cb9d54ae3ae340f60bb7a9a5215ccf04c57c3423f4f40a58e"
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
