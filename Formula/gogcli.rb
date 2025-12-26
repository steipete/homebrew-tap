class Gogcli < Formula
  desc "Google CLI for Gmail, Calendar, Drive, and Contacts"
  homepage "https://github.com/steipete/gogcli"
  url "https://github.com/steipete/gogcli/archive/refs/tags/v0.2.1.tar.gz"
  sha256 "47844aa25f1c4992457d3919c521f2c82e0aacdd45f57a3c2beaf60b80cea450"
  license "MIT"
  version "0.2.1"

  depends_on "go" => :build

  def install
    system "go", "build", *std_go_args(output: bin/"gog", ldflags: "-s -w"), "./cmd/gog"
  end

  test do
    assert_match "Google CLI", shell_output("#{bin}/gog --help")
  end
end
