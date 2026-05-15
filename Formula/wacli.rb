class Wacli < Formula
  desc "WhatsApp CLI built on whatsmeow"
  homepage "https://github.com/openclaw/wacli"
  version "0.9.0"
  license "MIT"

  on_macos do
    url "https://github.com/openclaw/wacli/releases/download/v0.9.0/wacli-macos-universal.tar.gz"
    sha256 "73a272a8257a762bddf89adc3872ed328a40ebfec319e5dc92ae9d40687e7c13"
  end

  on_linux do
    url "https://github.com/openclaw/wacli/archive/refs/tags/v0.9.0.tar.gz"
    sha256 "867034ca0ce3cf8de07d20fe135ec466acf0590f7b8d8ee065ea9d4ff8f2f717"
    depends_on "go" => :build
  end

  head "https://github.com/openclaw/wacli.git", branch: "main"

  def install
    if File.exist?("wacli")
      bin.install "wacli"
    else
      ldflags = "-s -w -X main.version=#{version}"
      # GCC 15+ with glibc 2.42+ treats missing-braces in Go's runtime/cgo as errors.
      # See: https://github.com/steipete/wacli/pull/8
      ENV["CGO_ENABLED"] = "1"
      ENV.append "CGO_CFLAGS", "-Wno-error=missing-braces"
      system "go", "build", "-tags", "sqlite_fts5", *std_go_args(ldflags: ldflags), "./cmd/wacli"
    end
  end

  test do
    assert_match "wacli", shell_output("#{bin}/wacli --version")
    assert_match "FTS5", shell_output("#{bin}/wacli doctor")
  end
end
