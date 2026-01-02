class Sag < Formula
  desc "Command-line ElevenLabs TTS with mac-style flags"
  homepage "https://github.com/steipete/sag"
  version "0.2.1"
  license "MIT"

  on_macos do
    url "https://github.com/steipete/sag/releases/download/v#{version}/sag_#{version}_darwin_universal.tar.gz"
    sha256 "391c008b47e09f64bca7b1e6ae1126210e6061ab5fddbccb803b6451954ccb9e"
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/steipete/sag/archive/refs/tags/v#{version}.tar.gz"
      sha256 "8d2d7a15062c62b31224400b7c86414ecb21806bd6f386cd82bb72d0d281fd03"
      depends_on "go" => :build
    else
      url "https://github.com/steipete/sag/releases/download/v#{version}/sag_#{version}_linux_amd64.tar.gz"
      sha256 "4e2f62f087cf4199fd65372b822a5b3fe76ef119608aefef5a9a8c11859e8382"
    end
  end

  def install
    if File.exist?("sag")
      bin.install "sag"
    else
      system "go", "build", *std_go_args(ldflags: "-s -w"), "./cmd/sag"
    end
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/sag --version")
  end
end
