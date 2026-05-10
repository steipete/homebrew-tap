class Gifgrep < Formula
  desc "Grep the GIF. Stick the landing"
  homepage "https://github.com/steipete/gifgrep"
  version "0.3.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/steipete/gifgrep/releases/download/v#{version}/gifgrep_#{version}_darwin_arm64.tar.gz"
      sha256 "94c7d7f98a7ba919b4924a84a58ae41f589186d339456998643b09c41629143d"
    else
      url "https://github.com/steipete/gifgrep/releases/download/v#{version}/gifgrep_#{version}_darwin_amd64.tar.gz"
      sha256 "03076d1c1b045c2b4ef30bd2a13f6b71a70fae288494dbd27e5690142630e33b"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/steipete/gifgrep/releases/download/v#{version}/gifgrep_#{version}_linux_arm64.tar.gz"
      sha256 "44b48564d8f780b151acde750b6161e337200056a633f6631c507d97da9b59a8"
    else
      url "https://github.com/steipete/gifgrep/releases/download/v#{version}/gifgrep_#{version}_linux_amd64.tar.gz"
      sha256 "7c8e42d4bb5ce226509022fcaf94b9ea1a0dea1fd60206179eed1eb7364eb68f"
    end
  end

  def install
    bin.install "gifgrep"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/gifgrep --version")
  end
end
