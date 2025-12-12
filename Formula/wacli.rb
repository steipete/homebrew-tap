class Wacli < Formula
  desc "WhatsApp CLI built on whatsmeow"
  homepage "https://github.com/steipete/wacli"
  url "https://github.com/steipete/wacli/archive/6038f64.tar.gz"
  sha256 "661ee3caa78435b0ccccb163b4b87ae4c5a79005158656c6dcbb98698e197f41"
  version "0.0.0-6038f64"
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
