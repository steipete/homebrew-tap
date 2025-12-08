class Sag < Formula
  desc "Command-line ElevenLabs TTS with mac-style flags"
  homepage "https://github.com/steipete/sag"
  url "https://github.com/steipete/sag/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "675c585e0cc9c4934fd7895d43474fb87a7e0cc0a7b00a00a5e78fd871e4317f"
  license "MIT"
  version "0.1.0"

  depends_on "go" => :build

  def install
    system "go", "build", *std_go_args(ldflags: "-s -w"), "./cmd/sag"
  end

  test do
    assert_match version, shell_output("#{bin}/sag --version")
  end
end
