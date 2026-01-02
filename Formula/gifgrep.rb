class Gifgrep < Formula
  desc "Grep the GIF. Stick the landing"
  homepage "https://github.com/steipete/gifgrep"
  version "0.1.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/steipete/gifgrep/releases/download/v#{version}/gifgrep_#{version}_darwin_arm64.tar.gz"
      sha256 "059e1947a2a983c8a53da3a71cee3837680d1a1b708f11c588260c9115af060c"
    else
      url "https://github.com/steipete/gifgrep/releases/download/v#{version}/gifgrep_#{version}_darwin_amd64.tar.gz"
      sha256 "07f8335d4cef1a68c8df5f97d164b17443bed2c336f5e5c60a67d22bc6b39632"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/steipete/gifgrep/archive/refs/tags/v#{version}.tar.gz"
      sha256 "241b473bf64f8d1318e6330269a20448eb24dfdef238dcd710c566d6817d0f5b"
      depends_on "go" => :build
    else
      url "https://github.com/steipete/gifgrep/releases/download/v#{version}/gifgrep_#{version}_linux_amd64.tar.gz"
      sha256 "8a0eca720fd6f00e52a76af4d1a3a40aa3325237e240f739561fa703c2a80bbc"
    end
  end

  def install
    if File.exist?("gifgrep")
      bin.install "gifgrep"
    else
      system "go", "build", *std_go_args(ldflags: "-s -w"), "./cmd/gifgrep"
    end
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/gifgrep --version")
  end
end
