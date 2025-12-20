class Summarize < Formula
  desc "Link → clean text → summary"
  homepage "https://github.com/steipete/summarize"
  url "https://github.com/steipete/summarize/releases/download/v0.3.0/summarize-macos-arm64-v0.3.0.tar.gz"
  sha256 "db975b8ee23d37df44655c178ea52c7fbace9e0396e09780a4df49daa222ac33"
  license "MIT"
  version "0.3.0"

  depends_on arch: :arm64

  def install
    bin.install "summarize"
  end

  def post_install
    chmod 0755, "#{bin}/summarize"
  end

  test do
    assert_match "0.3.0", shell_output("#{bin}/summarize --version")
    assert_match "Summarize web pages", shell_output("#{bin}/summarize --help")
  end
end
