class Wacli < Formula
  desc "WhatsApp CLI built on whatsmeow"
  homepage "https://github.com/openclaw/wacli"
  version "0.9.1"
  license "MIT"
  head "https://github.com/openclaw/wacli.git", branch: "main"

  on_macos do
    on_arm do
      url "https://github.com/openclaw/wacli/releases/download/v#{version}/wacli-macos-universal.tar.gz"
      sha256 "7b58d2513ed4848bc147ade9fa7ce4b9b1fcda858ac5595cfea1feb43bdb301a"
    end

    on_intel do
      url "https://github.com/openclaw/wacli/releases/download/v#{version}/wacli-macos-universal.tar.gz"
      sha256 "7b58d2513ed4848bc147ade9fa7ce4b9b1fcda858ac5595cfea1feb43bdb301a"
    end
  end

  on_linux do
    depends_on "go" => :build

    on_arm do
      url "https://github.com/openclaw/wacli/archive/refs/tags/v#{version}.tar.gz"
      sha256 "0084e2f80937fff976e4da51a05f509576bbc9a140c052a399dd3cf409f9a7d6"
    end

    on_intel do
      url "https://github.com/openclaw/wacli/archive/refs/tags/v#{version}.tar.gz"
      sha256 "0084e2f80937fff976e4da51a05f509576bbc9a140c052a399dd3cf409f9a7d6"
    end
  end

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
