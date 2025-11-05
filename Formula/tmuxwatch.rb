class Tmuxwatch < Formula
  desc "Live tmux dashboard with Bubble Tea UI"
  homepage "https://github.com/steipete/tmuxwatch"
  url "https://github.com/steipete/tmuxwatch/archive/refs/tags/v0.9.1.tar.gz"
  sha256 "75650cbbf0f9528125f62525bc3b39f3a53d12ef0f57674f68b2b30dc537c0cf"
  license "MIT"

  depends_on "go" => :build

  def install
    ldflags = "-s -w -X main.version=#{version}"
    system "go", "build", *std_go_args(ldflags:), "./cmd/tmuxwatch"
  end

  test do
    assert_match "tmuxwatch 0.9.1", shell_output("#{bin}/tmuxwatch --version")
  end
end
