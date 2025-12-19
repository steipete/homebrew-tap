class Summarize < Formula
  desc "Link → clean text → summary"
  homepage "https://github.com/steipete/summarize"
  url "https://github.com/steipete/summarize/releases/download/v0.1.0/summarize-macos-universal-v0.1.0.tar.gz"
  sha256 "2b0c540345afa0653a1c60b9c7d00a7457ebccdf5280819b8613f4c0656ecb67"
  license "MIT"
  version "0.1.0"

  def install
    bin.install "summarize"
  end

  def post_install
    chmod 0755, "#{bin}/summarize"
  end

  test do
    assert_match "0.1.0", shell_output("#{bin}/summarize --version")
    assert_match "Summarize web pages", shell_output("#{bin}/summarize --help")
  end
end
