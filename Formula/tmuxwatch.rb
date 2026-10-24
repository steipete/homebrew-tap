class Tmuxwatch < Formula
  desc "Live tmux dashboard with Bubble Tea UI"
  homepage "https://github.com/steipete/tmuxwatch"
  version "0.10.2"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/steipete/tmuxwatch/releases/download/v0.10.2/tmuxwatch_0.10.2_darwin_arm64.tar.gz"
      sha256 "3a7bce1ea7a92b81f54c5f9ced3d37cc5e864af88e3976cea70157fc2f634f58"
    else
      url "https://github.com/steipete/tmuxwatch/releases/download/v0.10.2/tmuxwatch_0.10.2_darwin_amd64.tar.gz"
      sha256 "02fa69d5da3baae4eb9cf426a9df539c26c4455cf5b46edef6f799d28bfe519a"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/steipete/tmuxwatch/releases/download/v0.10.2/tmuxwatch_0.10.2_linux_arm64.tar.gz"
      sha256 "a4349fd203d70097a6f9a1096affbc5cc92a70d8e4796879496b0b78f708f362"
    else
      url "https://github.com/steipete/tmuxwatch/releases/download/v0.10.2/tmuxwatch_0.10.2_linux_amd64.tar.gz"
      sha256 "c61772809876f7189b60362eddbfc89d418aaffe3fc3b5be1a59aeef33079578"
    end
  end

  def install
    bin.install "tmuxwatch"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/tmuxwatch --version")
  end
end
