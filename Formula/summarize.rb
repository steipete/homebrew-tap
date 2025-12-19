class Summarize < Formula
  desc "Link → clean text → summary"
  homepage "https://github.com/steipete/summarize"
  url "https://github.com/steipete/summarize/releases/download/v0.1.2/summarize-macos-universal-v0.1.2.tar.gz"
  sha256 "584cd2c6078dde02f9aa616e7f6bd198c8b676c370a7d88bf14084119f62e45a"
  license "MIT"
  version "0.1.2"

  def install
    bin.install "summarize"
  end

  def post_install
    chmod 0755, "#{bin}/summarize"
  end

  test do
    assert_match "0.1.2", shell_output("#{bin}/summarize --version")
    assert_match "Summarize web pages", shell_output("#{bin}/summarize --help")
  end
end
