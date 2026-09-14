class Sag < Formula
  desc "Command-line ElevenLabs TTS with mac-style flags"
  homepage "https://github.com/steipete/sag"
  url "https://github.com/steipete/sag/releases/download/v0.4.2/sag_0.4.2_darwin_universal.tar.gz"
  sha256 "bfab698af6e0aea0590b74f6667ac50edd5e430572be690404266529ece53954"
  license "MIT"

  on_linux do
    on_arm do
      url "https://github.com/steipete/sag/archive/refs/tags/v#{version}.tar.gz"
      sha256 "6e82a12451860484cb93c44bf63f1be8c7af83017352c6ab0ac3d9fe1784ec72"

      depends_on "go" => :build
      depends_on "pkgconf" => :build
      depends_on "alsa-lib"
    end

    on_intel do
      url "https://github.com/steipete/sag/releases/download/v#{version}/sag_#{version}_linux_amd64.tar.gz"
      sha256 "177ecbada101a538424d7f8c3961071f15a8a1b43365f169b0d9a69ba825ddfb"
    end
  end

  def install
    if File.exist?("sag")
      bin.install "sag"
    else
      if OS.linux? && Hardware::CPU.arm?
        ENV["CGO_ENABLED"] = "1"
        ENV.append "CGO_LDFLAGS", "-Wl,-rpath,#{formula_opt_lib("alsa-lib")}"
      end

      system "go", "build", *std_go_args(ldflags: "-s -w"), "./cmd/sag"
    end
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/sag --version")
  end
end
