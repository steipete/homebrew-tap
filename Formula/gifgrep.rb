class Gifgrep < Formula
  desc "Grep the GIF. Stick the landing"
  homepage "https://github.com/steipete/gifgrep"
  version "0.4.1"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/steipete/gifgrep/releases/download/v#{version}/gifgrep_#{version}_darwin_arm64.tar.gz"
      sha256 "771f1a581483cb64d8e5507f7c983041e5d1ed55e56c89abf0f8084d1c2726b7"
    else
      url "https://github.com/steipete/gifgrep/releases/download/v#{version}/gifgrep_#{version}_darwin_amd64.tar.gz"
      sha256 "6e2fe5f2fb08be11bf11dc9137705fe1853471703a5bf51adc401ff2346acfdb"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/steipete/gifgrep/releases/download/v#{version}/gifgrep_#{version}_linux_arm64.tar.gz"
      sha256 "5428e2eb10a00902f2c3738c2dfde9cef1da6f0fad70f7cce9eba377b551d788"
    else
      url "https://github.com/steipete/gifgrep/releases/download/v#{version}/gifgrep_#{version}_linux_amd64.tar.gz"
      sha256 "9878268ad1fcf70ff1c5cb7843b6d69db412f2f86ffa927a705ef8e7a86c6f85"
    end
  end

  def install
    bin.install "gifgrep"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/gifgrep --version")
  end
end
