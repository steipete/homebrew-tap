class Summarize < Formula
  desc "Link → clean text → summary"
  homepage "https://github.com/steipete/summarize"
  url "https://github.com/steipete/summarize/releases/download/v0.4.0/summarize-macos-arm64-v0.4.0.tar.gz"
  sha256 "18f145bac030e7fcbdd82d7d77f21ee35a91e6180b4a48db14daf510443d11a1"
  license "MIT"
  version "0.4.0"

  depends_on arch: :arm64

  def install
    bin.install "summarize"
  end

  def post_install
    chmod 0755, "#{bin}/summarize"
  end

  test do
    assert_match "0.4.0", shell_output("#{bin}/summarize --version")
    assert_match "Summarize web pages", shell_output("#{bin}/summarize --help")
  end
end
