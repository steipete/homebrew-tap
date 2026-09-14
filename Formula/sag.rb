class Sag < Formula
  desc "Command-line ElevenLabs TTS with mac-style flags"
  homepage "https://github.com/steipete/sag"
  url "https://github.com/steipete/sag/releases/download/v0.4.2/sag_0.4.2_darwin_universal.tar.gz"
  sha256 "bfab698af6e0aea0590b74f6667ac50edd5e430572be690404266529ece53954"
  license "MIT"

  on_linux do
    on_arm do
      url "https://github.com/steipete/sag/archive/refs/tags/v#{version}.tar.gz"
      sha256 "ee73ea2d703887c171968d6d113a60d1e9de649950fa44fee96ca2d484e94d5c"

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
