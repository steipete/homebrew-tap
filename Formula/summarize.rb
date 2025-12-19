class Summarize < Formula
  desc "Link → clean text → summary"
  homepage "https://github.com/steipete/summarize"
  url "https://github.com/steipete/summarize/releases/download/v0.1.1/summarize-macos-universal-v0.1.1.tar.gz"
  sha256 "dd771b069bc821a0ab9f9022711d2a3566d95fea1655441b1053320251dbc1f9"
  license "MIT"
  version "0.1.1"

  def install
    bin.install "summarize"
  end

  def post_install
    chmod 0755, "#{bin}/summarize"
  end

  test do
    assert_match "0.1.1", shell_output("#{bin}/summarize --version")
    assert_match "Summarize web pages", shell_output("#{bin}/summarize --help")
  end
end
