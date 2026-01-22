class Summarize < Formula
  desc "Link → clean text → summary"
  homepage "https://github.com/steipete/summarize"
  url "https://github.com/steipete/summarize/releases/download/v0.10.0/summarize-macos-arm64-v0.10.0.tar.gz"
  sha256 "0940dffd07b760053bd69904140d71fa746cc663389f3102cbc068dc4ce09d66"
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
