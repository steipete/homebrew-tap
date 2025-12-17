class Gogcli < Formula
  desc "Google CLI for Gmail, Calendar, Drive, and Contacts"
  homepage "https://github.com/steipete/gogcli"
  url "https://github.com/steipete/gogcli/archive/refs/tags/v0.1.1.tar.gz"
  sha256 "5ed777e0969a81e6208d881816a6a7f68eb76c7c20af77f31cdb33f8926e8da4"
  license "MIT"
  version "0.1.1"

  depends_on "go" => :build

  def install
    system "go", "build", *std_go_args(output: bin/"gog", ldflags: "-s -w"), "./cmd/gog"
  end

  test do
    assert_match "Google CLI", shell_output("#{bin}/gog --help")
  end
end
