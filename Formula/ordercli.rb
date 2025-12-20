class Ordercli < Formula
  desc "Multi-provider order CLI (Foodora, Deliveroo)"
  homepage "https://github.com/steipete/ordercli"
  url "https://github.com/steipete/ordercli/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "f455751ed946465e884dee8b8330019ca9b734fc23b4d0fdd3a9217156d72656"
  version "0.1.0"
  license "MIT"

  depends_on "go" => :build

  def install
    system "go", "build", *std_go_args, "./cmd/ordercli"
  end

  test do
    assert_match "multi-provider order CLI", shell_output("#{bin}/ordercli --help")
  end
end
