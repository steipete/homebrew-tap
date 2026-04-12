class Wacli < Formula
  desc "WhatsApp CLI built on whatsmeow"
  homepage "https://github.com/steipete/wacli"
  version "0.5.0"
  license "MIT"

  on_macos do
    url "https://github.com/steipete/wacli/releases/download/v#{version}/wacli-macos-universal.tar.gz"
    sha256 "064ac697aab2e79f08c33e085db95fe5932c1d41f066704728c373199e7a219a"
  end

  on_linux do
    url "https://github.com/steipete/wacli/archive/refs/tags/v#{version}.tar.gz"
    sha256 "f6fbd14e82e72263633ce484d92c7d39894797ddcdfb246effe503481f7692b9"
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
