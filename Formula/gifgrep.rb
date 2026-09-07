class Gifgrep < Formula
  desc "Grep the GIF. Stick the landing"
  homepage "https://github.com/steipete/gifgrep"
  version "0.4.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/steipete/gifgrep/releases/download/v#{version}/gifgrep_#{version}_darwin_arm64.tar.gz"
      sha256 "85bb505a62e14550b3d9dfa860a90374cd25bef2eaa4f8dc6bbcc7225ccb3494"
    else
      url "https://github.com/steipete/gifgrep/releases/download/v#{version}/gifgrep_#{version}_darwin_amd64.tar.gz"
      sha256 "e433eafdbdc15892c4e441cb44c1a960e48ffae5ffa4b8edb87adde3abb7dafc"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/steipete/gifgrep/releases/download/v#{version}/gifgrep_#{version}_linux_arm64.tar.gz"
      sha256 "0377e0a6ddf625d485e13ea357b65081472fe2d9cbe140280dbc8fa63e86fb24"
    else
      url "https://github.com/steipete/gifgrep/releases/download/v#{version}/gifgrep_#{version}_linux_amd64.tar.gz"
      sha256 "60ace0f9e69e9065c908934059150c25d4ccb48ad08b3daaed35446735295563"
    end
  end

  def install
    bin.install "gifgrep"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/gifgrep --version")
  end
end
