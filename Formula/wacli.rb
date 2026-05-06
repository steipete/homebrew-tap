class Wacli < Formula
  desc "WhatsApp CLI built on whatsmeow"
  homepage "https://github.com/steipete/wacli"
  version "0.7.0"
  license "MIT"

  on_macos do
    url "https://github.com/steipete/wacli/releases/download/v#{version}/wacli-macos-universal.tar.gz"
    sha256 "0245b67af2997f087951fc5539ec200a5f44881cff0ab69f1a6e233abda38666"
  end

  on_linux do
    url "https://github.com/steipete/wacli/archive/refs/tags/v#{version}.tar.gz"
    sha256 "27783a54ef51909207800e3a4d55334786f5d9a2fd394fb4744010602d89700c"
    depends_on "go" => :build
  end

  head "https://github.com/steipete/wacli.git", branch: "main"

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
