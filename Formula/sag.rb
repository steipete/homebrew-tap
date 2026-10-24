class Sag < Formula
  desc "Command-line ElevenLabs TTS with mac-style flags"
  homepage "https://github.com/steipete/sag"
  version "0.4.5"
  license "MIT"

  on_macos do
    depends_on macos: :sequoia

    if Hardware::CPU.arm?
      url "https://github.com/steipete/sag/releases/download/v0.4.5/sag_0.4.5_darwin_arm64.tar.gz"
      sha256 "59c22fe781acf298118fe9eae3aeecfd95b4ef5e258bda1a381bd2aaed4b136a"
    else
      url "https://github.com/steipete/sag/releases/download/v0.4.5/sag_0.4.5_darwin_amd64.tar.gz"
      sha256 "782179a16dbfe9c8105049b6723e365e6dbdaf1a238dfbc3befb3b2d333da538"
    end
  end

  on_linux do
    depends_on "patchelf" => :build
    depends_on "alsa-lib"

    if Hardware::CPU.arm?
      url "https://github.com/steipete/sag/releases/download/v0.4.5/sag_0.4.5_linux_arm64.tar.gz"
      sha256 "8f85a15bcfca08622360569046194aadec07f9a13e38bc01bbb085effaa8765f"
    else
      url "https://github.com/steipete/sag/releases/download/v0.4.5/sag_0.4.5_linux_amd64.tar.gz"
      sha256 "1b3a72a2c84b2ea572acdd9cc66da504a4cff318b8a26ad52eaa470753a2d789"
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
