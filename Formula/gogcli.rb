class Gogcli < Formula
  desc "Google CLI for Gmail, Calendar, Drive, and Contacts"
  homepage "https://github.com/steipete/gogcli"
  url "https://github.com/steipete/gogcli/archive/refs/tags/v0.2.0.tar.gz"
  sha256 "4d890e7fce40a6a95b3b4be9ffbca3e00b9b21c5b5ce3a163f6fa461005ec4c1"
  license "MIT"
  version "0.2.0"

  depends_on "go" => :build

  def install
    system "go", "build", *std_go_args(output: bin/"gog", ldflags: "-s -w"), "./cmd/gog"
  end

  test do
    assert_match "Google CLI", shell_output("#{bin}/gog --help")
  end
end
