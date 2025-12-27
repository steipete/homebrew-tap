class Sag < Formula
  desc "Command-line ElevenLabs TTS with mac-style flags"
  homepage "https://github.com/steipete/sag"
  url "https://github.com/steipete/sag/archive/refs/tags/v0.2.0.tar.gz"
  sha256 "513bbd509e6bbcccb205a41f1656e6fc1e27d3cb89a3349c23a0d9e85eaf8472"
  license "MIT"

  depends_on "go" => :build

  def install
    system "go", "build", *std_go_args(ldflags: "-s -w"), "./cmd/sag"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/sag --version")
  end
end
