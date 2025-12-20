class Summarize < Formula
  desc "Link → clean text → summary"
  homepage "https://github.com/steipete/summarize"
  url "https://github.com/steipete/summarize/releases/download/v0.2.0/summarize-macos-universal-v0.2.0.tar.gz"
  sha256 "c0847d74831e68ba7ae7903e3b509e0ae75821a26b362529816dd2b500482828"
  license "MIT"
  version "0.2.0"

  def install
    bin.install "summarize"
  end

  def post_install
    chmod 0755, "#{bin}/summarize"
  end

  test do
    assert_match "0.2.0", shell_output("#{bin}/summarize --version")
    assert_match "Summarize web pages", shell_output("#{bin}/summarize --help")
  end
end
