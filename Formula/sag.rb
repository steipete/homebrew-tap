class Sag < Formula
  desc "Command-line ElevenLabs TTS with mac-style flags"
  homepage "https://github.com/steipete/sag"
  url "https://github.com/steipete/sag/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "4cde050c7a4294b3c87c6e6cd4e7b219e377b26a5ae51490121b7bb18242c245"
  license "MIT"
  version "0.1.0"

  depends_on "go" => :build

  def install
    system "go", "build", *std_go_args(ldflags: "-s -w"), "./cmd/sag"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/sag --version")
  end
end
