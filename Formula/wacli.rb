class Wacli < Formula
  desc "WhatsApp CLI built on whatsmeow"
  homepage "https://github.com/steipete/wacli"
  version "0.1.1"
  license "MIT"

  on_macos do
    url "https://github.com/steipete/wacli/releases/download/v#{version}/wacli-macos-universal.tar.gz"
    sha256 "749c1b8856e176c9a6517ae4e562c45732955031ba304e4afab9c5555c4363ab"
  end

  on_linux do
    url "https://github.com/steipete/wacli/archive/refs/tags/v#{version}.tar.gz"
    sha256 "18a3575467e8fa4ab0563e1a1ad292bae9f4172478365b9e772a3ee488e00c58"
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
