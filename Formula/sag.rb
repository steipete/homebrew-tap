class Sag < Formula
  desc "Command-line ElevenLabs TTS with mac-style flags"
  homepage "https://github.com/steipete/sag"
  version "0.4.6"
  license "MIT"

  on_macos do
    depends_on macos: :sequoia

    if Hardware::CPU.arm?
      url "https://github.com/steipete/sag/releases/download/v0.4.6/sag_0.4.6_darwin_arm64.tar.gz"
      sha256 "bcd75399266b6b8a82c478a32bceee174d9eb745ed70afbcfa724b4fdc6812d2"
    else
      url "https://github.com/steipete/sag/releases/download/v0.4.6/sag_0.4.6_darwin_amd64.tar.gz"
      sha256 "6e3bb338912fd5c3e6207c2b9a18fa4060a6be17bdeb85b1f4e10796610d484c"
    end
  end

  on_linux do
    depends_on "patchelf" => :build
    depends_on "alsa-lib"

    if Hardware::CPU.arm?
      url "https://github.com/steipete/sag/releases/download/v0.4.6/sag_0.4.6_linux_arm64.tar.gz"
      sha256 "6dca984b54cde3efccb1960d8a5d5ef937d120ab08e99ebcc6f9e92bcbf731aa"
    else
      url "https://github.com/steipete/sag/releases/download/v0.4.6/sag_0.4.6_linux_amd64.tar.gz"
      sha256 "075607d9e68063f525e7462d4bd5171f6e94b0b63d8d2f54a358d1ce0c38f15c"
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
