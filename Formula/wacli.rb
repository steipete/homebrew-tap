class Wacli < Formula
  desc "WhatsApp CLI built on whatsmeow"
  homepage "https://github.com/openclaw/wacli"
  license "MIT"
  head "https://github.com/openclaw/wacli.git", branch: "main"

  on_macos do
    on_arm do
      url "https://github.com/openclaw/wacli/releases/download/v0.9.2/wacli-macos-universal.tar.gz"
      sha256 "9d61fbbf7128cadab5d4c3cafde3b6e14f7d3b87bdfff3ce505ecc458ba32bc4"
    end

    on_intel do
      url "https://github.com/openclaw/wacli/releases/download/v0.9.2/wacli-macos-universal.tar.gz"
      sha256 "9d61fbbf7128cadab5d4c3cafde3b6e14f7d3b87bdfff3ce505ecc458ba32bc4"
    end
  end

  on_linux do
    depends_on "go" => :build

    on_arm do
      url "https://github.com/openclaw/wacli/archive/refs/tags/v0.9.2.tar.gz"
      sha256 "34c33ce2fdbcc3460a1b4868db7b47fb523cbaff462b502138f67c0f9cd5fbe8"
    end

    on_intel do
      url "https://github.com/openclaw/wacli/archive/refs/tags/v0.9.2.tar.gz"
      sha256 "34c33ce2fdbcc3460a1b4868db7b47fb523cbaff462b502138f67c0f9cd5fbe8"
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
