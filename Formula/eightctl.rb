class Eightctl < Formula
  desc "Control Eight Sleep Pods from the terminal"
  homepage "https://github.com/steipete/eightctl"
  url "https://github.com/steipete/eightctl/archive/2f2c73f0a529e9138707a237135fcaadfe56617e.tar.gz"
  version "0.2.0-dev.20260504.2f2c73f"
  sha256 "849232d52e311dd0af17d0f7c2ec9b1b8b23f074d1c2e2eee788cf378b2f4b20"
  license "MIT"

  depends_on "go" => :build

  def install
    ldflags = "-s -w -X github.com/steipete/eightctl/internal/cmd.Version=#{version}"
    system "go", "build", *std_go_args(ldflags: ldflags), "./cmd/eightctl"
  end

  test do
    ENV["HOME"] = testpath

    assert_equal version.to_s, shell_output("#{bin}/eightctl version").strip
    assert_match "Control your Eight Sleep Pod", shell_output("#{bin}/eightctl --help")
    assert_match "missing required auth fields", shell_output("#{bin}/eightctl --quiet status 2>&1", 1)
  end
end
