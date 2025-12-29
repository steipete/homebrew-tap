class Summarize < Formula
  desc "Link → clean text → summary"
  homepage "https://github.com/steipete/summarize"
  url "https://github.com/steipete/summarize/releases/download/v0.8.2/summarize-macos-arm64-v0.8.2.tar.gz"
  sha256 "3bf11afb8378533c7018701104fd40288bf9792124b9d0c5a007a1e03f545e68"
  license "MIT"

  depends_on arch: :arm64

  def install
    bin.install "summarize"
  end

  def post_install
    chmod 0755, "#{bin}/summarize"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/summarize --version")
    assert_match "Summarize web pages", shell_output("#{bin}/summarize --help")
  end
end
