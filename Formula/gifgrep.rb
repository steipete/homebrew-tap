class Gifgrep < Formula
  desc "Grep the GIF. Stick the landing"
  homepage "https://github.com/steipete/gifgrep"
  url "https://github.com/steipete/gifgrep/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "241b473bf64f8d1318e6330269a20448eb24dfdef238dcd710c566d6817d0f5b"
  license "MIT"

  depends_on "go" => :build

  def install
    system "go", "build", *std_go_args(ldflags: "-s -w"), "./cmd/gifgrep"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/gifgrep --version")
  end
end
