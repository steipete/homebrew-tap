class Mcporter < Formula
  desc "Model Context Protocol runtime and CLI generator"
  homepage "https://github.com/steipete/mcporter"
  url "https://github.com/steipete/mcporter/releases/download/v0.3.4/mcporter-macos-arm64-v0.3.4.tar.gz"
  sha256 "cb2548766c828f4b148903912f64873be3a2ce96ce709e791ae4ccb09e1574bc"
  license "MIT"
  version "0.3.4"

  depends_on arch: :arm64

  def install
    bin.install "mcporter"
  end

  test do
    assert_match "Usage: mcporter <command>", shell_output("#{bin}/mcporter", 1)
  end
end
