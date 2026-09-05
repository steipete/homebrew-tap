class Gifgrep < Formula
  desc "Grep the GIF. Stick the landing"
  homepage "https://github.com/steipete/gifgrep"
  version "0.3.2"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/steipete/gifgrep/releases/download/v#{version}/gifgrep_#{version}_darwin_arm64.tar.gz"
      sha256 "2e202250e6980b3bd0096a98f50002b39af5314c9bccd93ba4840d98d943a9d8"
    else
      url "https://github.com/steipete/gifgrep/releases/download/v#{version}/gifgrep_#{version}_darwin_amd64.tar.gz"
      sha256 "c750479790fb68d2f37cf19466701c5ef76c92879712143e80816cd009c98763"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/steipete/gifgrep/releases/download/v#{version}/gifgrep_#{version}_linux_arm64.tar.gz"
      sha256 "cdd78f0f07f2465851db7ccdc126e4addf024c1691c369523d53c95a02c22751"
    else
      url "https://github.com/steipete/gifgrep/releases/download/v#{version}/gifgrep_#{version}_linux_amd64.tar.gz"
      sha256 "ac2e63b6abc574080418e033ba1c93cbaad4f815d03e1a24935e9d1fd9dbabf7"
    end
  end

  def install
    bin.install "gifgrep"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/gifgrep --version")
  end
end
