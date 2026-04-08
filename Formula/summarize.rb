class Summarize < Formula
  desc "Link → clean text → summary"
  homepage "https://github.com/steipete/summarize"
  license "MIT"

  # summarize Homebrew formula is macOS-only; use npm install -g @steipete/summarize on Linux
  depends_on :macos

  on_macos do
    on_arm do
      url "https://github.com/steipete/summarize/releases/download/v0.13.0/summarize-macos-arm64-v0.13.0.tar.gz"
      sha256 "16469ae13f9783ecce4d28707938e79e20c5f580ac68b14bc660514b74b532e2"
    end

    on_intel do
      url "https://github.com/steipete/summarize/releases/download/v0.13.0/summarize-macos-x64-v0.13.0.tar.gz"
      sha256 "832e593d06799bf32ab97d01c62cc6c80563f665b5db002b6acddb7851ec5266"
    end
  end

  def install
    bin.install "summarize"
  end

  def post_install
    chmod 0755, bin/"summarize"
  end

  test do
    assert_match version.to_s, shell_output("#{bin/"summarize"} --version")
    assert_match "Summarize web pages", shell_output("#{bin/"summarize"} --help")
  end
end
