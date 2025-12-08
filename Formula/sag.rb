class Sag < Formula
  desc "Command-line ElevenLabs TTS with mac-style flags"
  homepage "https://github.com/steipete/sag"
  url "https://github.com/steipete/sag/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "46df20553619e122677e24408cc2ae1902ae6674d9da49db268a99b416eb6a4f"
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
