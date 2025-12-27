class Gogcli < Formula
  desc "Google CLI for Gmail, Calendar, Drive, and Contacts"
  homepage "https://github.com/steipete/gogcli"
  url "https://github.com/steipete/gogcli/archive/refs/tags/v0.4.0.tar.gz"
  sha256 "14cdcc71723037cec91d2ad6af3f827b0c918c4012074994c16111c603dbdeba"
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
