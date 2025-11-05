class Tmuxwatch < Formula
  desc "Live tmux dashboard with Bubble Tea UI"
  homepage "https://github.com/steipete/tmuxwatch"
  url "https://github.com/steipete/tmuxwatch/archive/refs/tags/v0.9.2.tar.gz"
  sha256 "a3fb6a537082814dd52a472d71ef8d29693cef04f07f5b771b2c05529585464d"
  license "MIT"

  depends_on "go" => :build

  def install
    ldflags = "-s -w -X main.version=#{version}"
    system "go", "build", *std_go_args(ldflags:), "./cmd/tmuxwatch"
  end

  test do
    assert_match "tmuxwatch 0.9.2", shell_output("#{bin}/tmuxwatch --version")
  end
end
