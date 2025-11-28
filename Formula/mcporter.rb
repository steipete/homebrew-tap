class Mcporter < Formula
  desc "Model Context Protocol runtime and CLI generator"
  homepage "https://github.com/steipete/mcporter"
  url "https://github.com/steipete/mcporter/releases/download/v0.6.6/mcporter-macos-arm64-v0.6.6.tar.gz"
  sha256 "ecafbf932d5412645afdc7371513252df0647ce97580b0a4b512eada6c56ae7a"
  license "MIT"

  depends_on arch: :arm64

  def install
    bin.install "mcporter"
  end

  test do
    assert_match "Usage: mcporter <command>", shell_output("#{bin}/mcporter", 1)
  end
end
