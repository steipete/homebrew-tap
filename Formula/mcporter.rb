class Mcporter < Formula
  desc "Model Context Protocol runtime and CLI generator"
  homepage "https://github.com/steipete/mcporter"
  url "https://github.com/steipete/mcporter/releases/download/v0.9.0/mcporter-macos-arm64-v0.9.0.tar.gz"
  sha256 "20cae1f412c8790d1801bd557825b12bb6354e73bd277be5484e53a58cf81c0b"
  license "MIT"

  depends_on arch: :arm64

  def install
    bin.install "mcporter"
  end

  test do
    assert_match "Usage: mcporter <command>", shell_output("#{bin}/mcporter", 1)
  end
end
