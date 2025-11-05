class Tmuxwatch < Formula
  desc "Live tmux dashboard with Bubble Tea UI"
  homepage "https://github.com/steipete/tmuxwatch"
  url "https://github.com/steipete/tmuxwatch/archive/refs/tags/v0.9.tar.gz"
  sha256 "232facf5ddf0b12347bf0e45d0428e95cf76fabc107930d98817382dbce6797d"
  license "MIT"

  depends_on "go" => :build

  def install
    ldflags = "-s -w -X main.version=#{version}"
    system "go", "build", *std_go_args(ldflags:), "./cmd/tmuxwatch"
  end

  test do
    assert_match "tmuxwatch 0.9", shell_output("#{bin}/tmuxwatch --version")
  end
end
