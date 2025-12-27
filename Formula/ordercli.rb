class Ordercli < Formula
  desc "Multi-provider order CLI (Foodora, Deliveroo)"
  homepage "https://github.com/steipete/ordercli"
  url "https://github.com/steipete/ordercli/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "03c06c099f21c4a9819e2804522903d84ea8a52044f119ce9846c78243ffd68f"
  license "MIT"

  depends_on "go" => :build

  def install
    system "go", "build", *std_go_args, "./cmd/ordercli"
  end

  test do
    assert_match "multi-provider order CLI", shell_output("#{bin}/ordercli --help")
  end
end
