class Sag < Formula
  desc "Command-line ElevenLabs TTS with mac-style flags"
  homepage "https://github.com/steipete/sag"
  version "0.4.3"
  license "MIT"

  on_macos do
    depends_on macos: :sequoia

    if Hardware::CPU.arm?
      url "https://github.com/steipete/sag/releases/download/v0.4.3/sag_0.4.3_darwin_arm64.tar.gz"
      sha256 "7bce8158870fa0186dcce2caa2f9cdab0871b479e8c9261b51250c8623636f14"
    else
      url "https://github.com/steipete/sag/releases/download/v0.4.3/sag_0.4.3_darwin_amd64.tar.gz"
      sha256 "7a24ed7cd2ee02d526226a846732089fa8239ca31a2a854aed21ad4686144bfb"
    end
  end

  on_linux do
    depends_on "patchelf" => :build
    depends_on "alsa-lib"

    if Hardware::CPU.arm?
      url "https://github.com/steipete/sag/releases/download/v0.4.3/sag_0.4.3_linux_arm64.tar.gz"
      sha256 "176be4b6efd455f95d9ce3c4298000be96601c4d0d9769ad379131c8a509f5eb"
    else
      url "https://github.com/steipete/sag/releases/download/v0.4.3/sag_0.4.3_linux_amd64.tar.gz"
      sha256 "3d76ab25e42605261a84c0e0f86c5a83ab18e697d1b0a774528eb261030c4de2"
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
