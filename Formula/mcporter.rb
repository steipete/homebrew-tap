class Mcporter < Formula
  desc "Model Context Protocol runtime and CLI generator"
  homepage "https://github.com/steipete/mcporter"
  url "https://github.com/steipete/mcporter/releases/download/v0.6.5/mcporter-macos-arm64-v0.6.5.tar.gz"
  sha256 "df4a8dd3b1f35160ed2421b07d49a9884edb63fed308f0a2c26d6baf223f9274"
  license "MIT"

  depends_on arch: :arm64

  def install
    bin.install "mcporter"
  end

  test do
    assert_match "Usage: mcporter <command>", shell_output("#{bin}/mcporter", 1)
  end
end
