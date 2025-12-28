class Gogcli < Formula
  desc "Google CLI for Gmail, Calendar, Drive, and Contacts"
  homepage "https://github.com/steipete/gogcli"
  url "https://github.com/steipete/gogcli/archive/refs/tags/v0.4.1.tar.gz"
  sha256 "365946545efac935535800ba689fbe23732fb6ae11c91125b4abd843ded6e980"
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
