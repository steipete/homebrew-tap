class Wacli < Formula
  desc "WhatsApp CLI built on whatsmeow"
  homepage "https://github.com/openclaw/wacli"
  version "0.8.1"
  license "MIT"

  on_macos do
    url "https://github.com/openclaw/wacli/releases/download/v0.8.1/wacli-macos-universal.tar.gz"
    sha256 "8cbff51a97b93903ca46fc258b8a9affced7e921d35c69379916ce757f8f1183"
  end

  on_linux do
    url "https://github.com/openclaw/wacli/archive/refs/tags/v0.8.1.tar.gz"
    sha256 "f1e8f369655860d1d23ac669b2639531f4f36d57720a8e935e6d9c9c9fe7294a"
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
