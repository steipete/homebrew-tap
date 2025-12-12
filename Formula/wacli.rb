class Wacli < Formula
  desc "WhatsApp CLI built on whatsmeow"
  homepage "https://github.com/steipete/wacli"
  url "https://github.com/steipete/wacli/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "147c97f60fb85573a77bfbd69f8a14a3ee82a98e2d989d42895fe61000e695fa"
  version "0.1.0"
  head "https://github.com/steipete/wacli.git", branch: "main"
  license "MIT"

  depends_on "go" => :build

  def install
    ldflags = "-s -w -X main.version=#{version}"
    system "go", "build", "-tags", "sqlite_fts5", *std_go_args(ldflags: ldflags), "./cmd/wacli"
  end

  test do
    assert_match "wacli", shell_output("#{bin}/wacli --version")
    assert_match "FTS5", shell_output("#{bin}/wacli doctor")
  end
end
