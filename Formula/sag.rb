class Sag < Formula
  desc "Command-line ElevenLabs TTS with mac-style flags"
  homepage "https://github.com/steipete/sag"
  version "0.4.4"
  license "MIT"

  on_macos do
    depends_on macos: :sequoia

    if Hardware::CPU.arm?
      url "https://github.com/steipete/sag/releases/download/v0.4.4/sag_0.4.4_darwin_arm64.tar.gz"
      sha256 "43c56c18cbcc0fc4605c2f8ddfbcb5a323c54fd675749f1fa999205aafaad9fc"
    else
      url "https://github.com/steipete/sag/releases/download/v0.4.4/sag_0.4.4_darwin_amd64.tar.gz"
      sha256 "0a42f7f5be4238cd38d2c39d13196b33ef96c8b7e52f313c9e26c3cf154cec5d"
    end
  end

  on_linux do
    depends_on "patchelf" => :build
    depends_on "alsa-lib"

    if Hardware::CPU.arm?
      url "https://github.com/steipete/sag/releases/download/v0.4.4/sag_0.4.4_linux_arm64.tar.gz"
      sha256 "29bf6ddbfd9f3a2d11b316557867ddfdafbd6864430fbd2c1b0e587cb819c13b"
    else
      url "https://github.com/steipete/sag/releases/download/v0.4.4/sag_0.4.4_linux_amd64.tar.gz"
      sha256 "126567fa98fcb93c9ca86069976a2add60c3a94e9236615af784710fcd401ac4"
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
