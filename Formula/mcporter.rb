class Mcporter < Formula
  desc "Model Context Protocol runtime and CLI generator"
  homepage "https://github.com/steipete/mcporter"
  url "https://github.com/steipete/mcporter/releases/download/v0.5.2/mcporter-macos-arm64-v0.5.2.tar.gz"
  sha256 "bbdb450d7959dd6798a52515e1e28f7bc29d0580349a9a1d14fdcb3fa4716477"
  license "MIT"
  version "0.5.2"

  depends_on arch: :arm64

  def install
    bin.install "mcporter"
  end

  test do
    assert_match "Usage: mcporter <command>", shell_output("#{bin}/mcporter", 1)
  end
end
