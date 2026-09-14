class Tmuxwatch < Formula
  desc "Live tmux dashboard with Bubble Tea UI"
  homepage "https://github.com/steipete/tmuxwatch"
  version "0.10.1"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/steipete/tmuxwatch/releases/download/v0.10.1/tmuxwatch_0.10.1_darwin_arm64.tar.gz"
      sha256 "9e7e72aa33686140542530216b984d9669bc0484eca1b702ca75f382bfda2c3b"
    else
      url "https://github.com/steipete/tmuxwatch/releases/download/v0.10.1/tmuxwatch_0.10.1_darwin_amd64.tar.gz"
      sha256 "15ea4a40e8fdc4f418c0e73850b8dd28bfb891f46010fc3e151537c7b63fb6fb"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/steipete/tmuxwatch/releases/download/v0.10.1/tmuxwatch_0.10.1_linux_arm64.tar.gz"
      sha256 "9a994e6e40d11571f49829e4118e576239208b162e41e3e1fd038534ae46e56a"
    else
      url "https://github.com/steipete/tmuxwatch/releases/download/v0.10.1/tmuxwatch_0.10.1_linux_amd64.tar.gz"
      sha256 "98a685500974dc520143fa7868ea016793bf0d8645cf168d8916cfcf1994d83a"
    end
  end

  def install
    bin.install "tmuxwatch"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/tmuxwatch --version")
  end
end
