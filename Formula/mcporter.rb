class Mcporter < Formula
  desc "Model Context Protocol runtime and CLI generator"
  homepage "https://github.com/steipete/mcporter"
  url "https://github.com/steipete/mcporter/releases/download/v0.3.3/mcporter-macos-arm64-v0.3.3.tar.gz"
  sha256 "efedbabf77c736bf99834ace099657f58e267dc548c6649f1550e9f53b77aa53"
  license "MIT"
  version "0.3.3"

  depends_on arch: :arm64

  def install
    bin.install "mcporter"
  end

  test do
    assert_match "Usage: mcporter <command>", shell_output("#{bin}/mcporter", 1)
  end
end
