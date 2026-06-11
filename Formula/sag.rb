class Sag < Formula
  desc "Command-line ElevenLabs TTS with mac-style flags"
  homepage "https://github.com/steipete/sag"
  url "https://github.com/steipete/sag/releases/download/v0.4.0/sag_0.4.0_darwin_universal.tar.gz"
  sha256 "d4b201312ce2a2cf2b42bc98c47656b8adb09bf05be1086f0703c5ca318180af"
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
      sha256 "b6e8deb2d254b4cc4a9008dc4544c693784bf7492cb63439a03674eaf483055c"
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
