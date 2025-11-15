class Mcporter < Formula
  desc "Model Context Protocol runtime and CLI generator"
  homepage "https://github.com/steipete/mcporter"
  url "https://github.com/steipete/mcporter/releases/download/v0.5.9/mcporter-macos-arm64-v0.5.9.tar.gz"
  sha256 "705f26904ab2caf6d8c2efb3108e52a3faffb890c3d50a00784c1067a8709ddb"
  license "MIT"
  version "0.5.9"

  depends_on arch: :arm64

  def install
    bin.install "mcporter"
  end

  test do
    assert_match "Usage: mcporter <command>", shell_output("#{bin}/mcporter", 1)
  end
end
