class Tmuxwatch < Formula
  desc "Live tmux dashboard with Bubble Tea UI"
  homepage "https://github.com/steipete/tmuxwatch"
  version "0.10.3"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/steipete/tmuxwatch/releases/download/v0.10.3/tmuxwatch_0.10.3_darwin_arm64.tar.gz"
      sha256 "36daf4cb08d25d1535ca900fad715edde67843dfc2bbcae411e9caf25644c6c4"
    else
      url "https://github.com/steipete/tmuxwatch/releases/download/v0.10.3/tmuxwatch_0.10.3_darwin_amd64.tar.gz"
      sha256 "89e19bfbb403b4790c2118583bb439ce6df562d68096a5ef5dcec43d93007f58"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/steipete/tmuxwatch/releases/download/v0.10.3/tmuxwatch_0.10.3_linux_arm64.tar.gz"
      sha256 "e0d15805b4ef300cdee33b9fd4c1c6e10848adc4362b2d1da725dbead2b45422"
    else
      url "https://github.com/steipete/tmuxwatch/releases/download/v0.10.3/tmuxwatch_0.10.3_linux_amd64.tar.gz"
      sha256 "1b4e5f1475ab39256c114653dd260e14cde831c75498de51fbdb7aeb315d394c"
    end
  end

  def install
    bin.install "tmuxwatch"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/tmuxwatch --version")
  end
end
