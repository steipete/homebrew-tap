class Mcporter < Formula
  desc "Model Context Protocol runtime and CLI generator"
  homepage "https://github.com/steipete/mcporter"
  url "https://github.com/steipete/mcporter/releases/download/v0.7.1/mcporter-macos-arm64-v0.7.1.tar.gz"
  sha256 "70843fd029868fe21c4c83874e77c29d0b027cb15369fd6351663e60ec69bd23"
  license "MIT"

  depends_on arch: :arm64

  def install
    bin.install "mcporter"
  end

  test do
    assert_match "Usage: mcporter <command>", shell_output("#{bin}/mcporter", 1)
  end
end
