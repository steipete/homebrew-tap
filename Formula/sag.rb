class Sag < Formula
  desc "Command-line ElevenLabs TTS with mac-style flags"
  homepage "https://github.com/steipete/sag"
  version "0.2.2"
  license "MIT"

  on_macos do
    url "https://github.com/steipete/sag/releases/download/v#{version}/sag_#{version}_darwin_universal.tar.gz"
    sha256 "0554baef912217d9e1f3988fb6d7492d46d2f49105a5eb9175e3f861f39cd289"
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/steipete/sag/archive/refs/tags/v#{version}.tar.gz"
      sha256 "82a09382d6803396e29a3fdc1d1d4982ffd97d69b5c6f9b6e31d0fb3818450db"
      depends_on "go" => :build
    else
      url "https://github.com/steipete/sag/releases/download/v#{version}/sag_#{version}_linux_amd64.tar.gz"
      sha256 "fddfe2553648fd9cd3446610c55176d897850d79f4aa95d60b605d387ffabdc8"
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
