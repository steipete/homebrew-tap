class Summarize < Formula
  desc "Link → clean text → summary"
  homepage "https://github.com/steipete/summarize"
  url "https://github.com/steipete/summarize/releases/download/v0.9.0/summarize-macos-arm64-v0.9.0.tar.gz"
  sha256 "07afde51c6efe0af64828ce8d5f10b157f8d3466b40bae1d07a392c9dc2ee80f"
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
