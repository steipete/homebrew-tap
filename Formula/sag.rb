class Sag < Formula
  desc "Command-line ElevenLabs TTS with mac-style flags"
  homepage "https://github.com/steipete/sag"
  url "https://github.com/steipete/sag/releases/download/v0.4.0/sag_0.4.0_darwin_universal.tar.gz"
  sha256 "b3366e8426f146e99761d7132c6d962db6c6933574e8c0e6f1b5ce50fbb7b94f"
  license "MIT"

  on_linux do
    on_arm do
      url "https://github.com/steipete/sag/archive/refs/tags/v#{version}.tar.gz"
      sha256 "acb6f2d626ce47640dc71c927dae27c6c104bab727dfa4f5bb14ebea80c11a63"

      depends_on "go" => :build
      depends_on "pkgconf" => :build
      depends_on "alsa-lib"
    end

    on_intel do
      url "https://github.com/steipete/sag/releases/download/v#{version}/sag_#{version}_linux_amd64.tar.gz"
      sha256 "4f080722ce0155c795bfa264491793bd56be6c3a18b4cae68cbe666fa922202f"
    end
  end

  def install
    if File.exist?("sag")
      bin.install "sag"
    else
      if OS.linux? && Hardware::CPU.arm?
        ENV["CGO_ENABLED"] = "1"
        ENV.append "CGO_LDFLAGS", "-Wl,-rpath,#{Formula["alsa-lib"].opt_lib}"
      end

      system "go", "build", *std_go_args(ldflags: "-s -w"), "./cmd/sag"
    end
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/sag --version")
  end
end
