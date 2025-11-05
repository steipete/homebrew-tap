class Tmuxwatch < Formula
  desc "Live tmux dashboard with Bubble Tea UI"
  homepage "https://github.com/steipete/tmuxwatch"
  url "https://github.com/steipete/tmuxwatch/archive/refs/tags/v1.0.0.tar.gz"
  sha256 "73c0dbf47b3edb25f2b65afd8e84d51c4223f7fdec871f809cb503d042ee838d"
  license "MIT"

  depends_on "go" => :build

  def install
    ldflags = "-s -w -X main.version=#{version}"
    system "go", "build", *std_go_args(ldflags:)
  end

  test do
    assert_match "tmuxwatch 1.0.0", shell_output("#{bin}/tmuxwatch --version")
  end
end
