class Gifgrep < Formula
  desc "Grep the GIF. Stick the landing"
  homepage "https://github.com/steipete/gifgrep"
  version "0.4.3"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/steipete/gifgrep/releases/download/v0.4.3/gifgrep_0.4.3_darwin_arm64.tar.gz"
      sha256 "411437a3f6f9c6852280e79a40861a6b48820b722bb157fbb783aa0a1e3596a0"
    else
      url "https://github.com/steipete/gifgrep/releases/download/v0.4.3/gifgrep_0.4.3_darwin_amd64.tar.gz"
      sha256 "a94026ceb53512460583453c9c1d0485f10d73da29104da7a9fae97350f33757"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/steipete/gifgrep/releases/download/v0.4.3/gifgrep_0.4.3_linux_arm64.tar.gz"
      sha256 "cd276e0ec8c2095a4260e44bf5bbd4bc6f5d2f139ffbaa5f22e38463a9355866"
    else
      url "https://github.com/steipete/gifgrep/releases/download/v0.4.3/gifgrep_0.4.3_linux_amd64.tar.gz"
      sha256 "1a5bb0392719aff9bf2e5556ebc24472432db7b52389591526b9656c252b3518"
    end
  end

  def install
    bin.install "gifgrep"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/gifgrep --version")
  end
end
