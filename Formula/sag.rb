class Sag < Formula
  desc "Command-line ElevenLabs TTS with mac-style flags"
  homepage "https://github.com/steipete/sag"
  version "0.4.2"
  license "MIT"

  on_macos do
    depends_on macos: :sequoia

    if Hardware::CPU.arm?
      url "https://github.com/steipete/sag/releases/download/v0.4.2/sag_0.4.2_darwin_arm64.tar.gz"
      sha256 "20f793ee7de3d08d95aca4b83268f0bb6a263b6888f89baea985c637fa551c6f"
    else
      url "https://github.com/steipete/sag/releases/download/v0.4.2/sag_0.4.2_darwin_amd64.tar.gz"
      sha256 "908b72992e75a64bc81194564e87c8adcec63690e31e23ac27c8c0bbe245b232"
    end
  end

  on_linux do
    depends_on "patchelf" => :build
    depends_on "alsa-lib"

    if Hardware::CPU.arm?
      url "https://github.com/steipete/sag/releases/download/v0.4.2/sag_0.4.2_linux_arm64.tar.gz"
      sha256 "488cab1ebbb928d8babff2794977313e26c33492b050253553c711a755758531"
    else
      url "https://github.com/steipete/sag/releases/download/v0.4.2/sag_0.4.2_linux_amd64.tar.gz"
      sha256 "177ecbada101a538424d7f8c3961071f15a8a1b43365f169b0d9a69ba825ddfb"
    end
  end

  skip_clean "bin/sag"

  def install
    bin.install "sag"
    return unless OS.linux?

    system "patchelf", "--set-rpath", formula_opt_lib("alsa-lib"), bin/"sag"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/sag --version")
  end
end
