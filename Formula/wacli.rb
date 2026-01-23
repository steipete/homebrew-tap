class Wacli < Formula
  desc "WhatsApp CLI built on whatsmeow"
  homepage "https://github.com/steipete/wacli"
  version "0.2.0"
  license "MIT"

  on_macos do
    url "https://github.com/steipete/wacli/releases/download/v#{version}/wacli-macos-universal.tar.gz"
    sha256 "7c42cc5b60caeef44286bb867f235f5d8d09c24419271590d86ca8e4ef385703"
  end

  on_linux do
    url "https://github.com/steipete/wacli/archive/refs/tags/v#{version}.tar.gz"
    sha256 "80fc82c7f77f63b25434d8f926f0d9d8d57592d971e37495698b757198beac42"
    depends_on "go" => :build
  end

  head "https://github.com/steipete/wacli.git", branch: "main"

  def install
    if File.exist?("wacli")
      bin.install "wacli"
    else
      ldflags = "-s -w -X main.version=#{version}"
      system "go", "build", "-tags", "sqlite_fts5", *std_go_args(ldflags: ldflags), "./cmd/wacli"
    end
  end

  test do
    assert_match "wacli", shell_output("#{bin}/wacli --version")
    assert_match "FTS5", shell_output("#{bin}/wacli doctor")
  end
end
