class Gogcli < Formula
  desc "Google CLI for Gmail, Calendar, Drive, and Contacts"
  homepage "https://github.com/steipete/gogcli"
  url "https://github.com/steipete/gogcli/archive/refs/tags/v0.3.0.tar.gz"
  sha256 "a5155b28e00fd58e9a917b6785ca6186810180af52a1a8da0a4a85faaf605280"
  license "MIT"
  version "0.3.0"

  depends_on "go" => :build

  def install
    ldflags = "-s -w -X github.com/steipete/gogcli/internal/cmd.version=v#{version}"
    system "go", "build", *std_go_args(output: bin/"gog", ldflags:), "./cmd/gog"
  end

  test do
    assert_match "v#{version}", shell_output("#{bin}/gog --version")
  end
end
