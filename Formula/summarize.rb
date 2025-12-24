class Summarize < Formula
  desc "Link → clean text → summary"
  homepage "https://github.com/steipete/summarize"
  url "https://github.com/steipete/summarize/releases/download/v0.5.0/summarize-macos-arm64-v0.5.0.tar.gz"
  sha256 "5b35d3a92598a4a0103c9c48fcdd003b62fa0ef1731ffe59c776a197a8ac978a"
  license "MIT"
  version "0.5.0"

  depends_on arch: :arm64

  def install
    bin.install "summarize"
  end

  def post_install
    chmod 0755, "#{bin}/summarize"
  end

  test do
    assert_match "0.5.0", shell_output("#{bin}/summarize --version")
    assert_match "Summarize web pages", shell_output("#{bin}/summarize --help")
  end
end
