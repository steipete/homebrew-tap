class Mcporter < Formula
  desc "Model Context Protocol runtime and CLI generator"
  homepage "https://github.com/steipete/mcporter"
  url "https://github.com/steipete/mcporter/releases/download/v0.5.7/mcporter-macos-arm64-v0.5.7.tar.gz"
  sha256 "eaadd84b712caee3d69887f7c0eab28b4a99678191893417149465d32eb8aab9"
  license "MIT"
  version "0.5.7"

  depends_on arch: :arm64

  def install
    bin.install "mcporter"
  end

  test do
    assert_match "Usage: mcporter <command>", shell_output("#{bin}/mcporter", 1)
  end
end
