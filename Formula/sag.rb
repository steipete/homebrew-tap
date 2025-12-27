class Sag < Formula
  desc "Command-line ElevenLabs TTS with mac-style flags"
  homepage "https://github.com/steipete/sag"
  url "https://github.com/steipete/sag/archive/refs/tags/v0.2.0.tar.gz"
  sha256 "a505a5eb0d72ede07768e96f17574c37959dacdde03434360b1a74c60d9c11cc"
  license "MIT"

  depends_on "go" => :build

  def install
    system "go", "build", *std_go_args(ldflags: "-s -w"), "./cmd/sag"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/sag --version")
  end
end
