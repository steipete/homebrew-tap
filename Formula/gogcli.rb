class Gogcli < Formula
  desc "Google CLI for Gmail, Calendar, Drive, and Contacts"
  homepage "https://github.com/steipete/gogcli"
  url "https://github.com/steipete/gogcli/archive/refs/tags/v0.4.2.tar.gz"
  sha256 "80534720574b2c24ce353ab86009056c70201f777a35be258e1c1de0c3a9a02a"
  license "MIT"

  depends_on "go" => :build

  def install
    ldflags = "-s -w -X github.com/steipete/gogcli/internal/cmd.version=v#{version}"
    system "go", "build", *std_go_args(output: bin/"gog", ldflags:), "./cmd/gog"
  end

  test do
    assert_match "v#{version}", shell_output("#{bin}/gog --version")
  end
end
