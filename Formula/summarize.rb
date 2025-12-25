class Summarize < Formula
  desc "Link → clean text → summary"
  homepage "https://github.com/steipete/summarize"
  url "https://github.com/steipete/summarize/releases/download/v0.6.0/summarize-macos-arm64-v0.6.0.tar.gz"
  sha256 "576876e8ac3fc85db2ffb95edd17936ebf5167d8a7c27fde228745b9c659f4a2"
  license "MIT"
  version "0.6.0"

  depends_on arch: :arm64

  def install
    bin.install "summarize"
  end

  def post_install
    chmod 0755, "#{bin}/summarize"
  end

  test do
    assert_match "0.6.0", shell_output("#{bin}/summarize --version")
    assert_match "Summarize web pages", shell_output("#{bin}/summarize --help")
  end
end
