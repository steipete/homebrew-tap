class Summarize < Formula
  desc "Link → clean text → summary"
  homepage "https://github.com/steipete/summarize"
  url "https://github.com/steipete/summarize/releases/download/v0.11.1/summarize-macos-arm64-v0.11.1.tar.gz"
  sha256 "44935e0b159f6cc08eac3e80051e304802ddb65d6c2264b85a48f3d5374f9931"
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
