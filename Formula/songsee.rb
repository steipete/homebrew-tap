class Songsee < Formula
  desc "Spectral visualization CLI for audio files"
  homepage "https://github.com/openclaw/songsee"
  url "https://github.com/openclaw/songsee/archive/refs/tags/v0.1.1.tar.gz"
  sha256 "042fe6796cbd84d68484eb450ce1f9e45c8d977a48f6b54670a67715505b1aad"
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
