class Sag < Formula
  desc "Command-line ElevenLabs TTS with mac-style flags"
  homepage "https://github.com/steipete/sag"
  url "https://github.com/steipete/sag/archive/refs/tags/v0.2.1.tar.gz"
  sha256 "8d2d7a15062c62b31224400b7c86414ecb21806bd6f386cd82bb72d0d281fd03"
  license "MIT"

  depends_on "go" => :build

  def install
    system "go", "build", *std_go_args(ldflags: "-s -w"), "./cmd/sag"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/sag --version")
  end
end
