class Wacli < Formula
  desc "WhatsApp CLI built on whatsmeow"
  homepage "https://github.com/steipete/wacli"
  url "https://github.com/steipete/wacli/archive/refs/tags/v0.1.1.tar.gz"
  sha256 "18a3575467e8fa4ab0563e1a1ad292bae9f4172478365b9e772a3ee488e00c58"
  license "MIT"
  head "https://github.com/steipete/wacli.git", branch: "main"

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
