class Tmuxwatch < Formula
  desc "Live tmux dashboard with Bubble Tea UI"
  homepage "https://github.com/steipete/tmuxwatch"
  version "0.10.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/steipete/tmuxwatch/releases/download/v#{version}/tmuxwatch_#{version}_darwin_arm64.tar.gz"
      sha256 "de69421c1b1a36c95c4da5c8b858bd1483e36c7d586b1f823efcc1dbb5364c50"
    else
      url "https://github.com/steipete/tmuxwatch/releases/download/v#{version}/tmuxwatch_#{version}_darwin_amd64.tar.gz"
      sha256 "14303fd1d5d3daaa128c406f1fdd4977cc3789f0537d0128d493eecb86b20ab9"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/steipete/tmuxwatch/releases/download/v#{version}/tmuxwatch_#{version}_linux_arm64.tar.gz"
      sha256 "7d24086dbe0036af34f1c8c680cdb65bf4464d67226fcac5dd326444c642d123"
    else
      url "https://github.com/steipete/tmuxwatch/releases/download/v#{version}/tmuxwatch_#{version}_linux_amd64.tar.gz"
      sha256 "880b543cf48cb1b865e9bbacdb20bd2269305a14a3a261dd0f0ac29a845054cd"
    end
  end

  def install
    bin.install "tmuxwatch"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/tmuxwatch --version")
  end
end
