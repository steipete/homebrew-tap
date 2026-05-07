class Wacli < Formula
  desc "WhatsApp CLI built on whatsmeow"
  homepage "https://github.com/openclaw/wacli"
  version "0.8.0"
  license "MIT"

  on_macos do
    url "https://github.com/openclaw/wacli/releases/download/v#{version}/wacli-macos-universal.tar.gz"
    sha256 "97de915b1121f4838b1ff3587fb07a430c0d6039351000e233ebea30a09eaca8"
  end

  on_linux do
    url "https://github.com/openclaw/wacli/archive/refs/tags/v#{version}.tar.gz"
    sha256 "d3e89456086ac85cfed2085941b5cd9a0ff176b47b834a6f774e6747de7482f0"
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
