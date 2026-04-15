class Wacli < Formula
  desc "WhatsApp CLI built on whatsmeow"
  homepage "https://github.com/steipete/wacli"
  version "0.6.0"
  license "MIT"

  on_macos do
    url "https://github.com/steipete/wacli/releases/download/v#{version}/wacli-macos-universal.tar.gz"
    sha256 "63c2be44462c88e0aa718ed4e3e9b2abc5de16bfc1b43af4efcc6bda059b1ecb"
  end

  on_linux do
    url "https://github.com/steipete/wacli/archive/refs/tags/v#{version}.tar.gz"
    sha256 "3b673f252ebdfcfc3225b646b32271b3b1cf15807a561a3abb20448025846d14"
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
