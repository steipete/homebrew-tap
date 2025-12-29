class Mcporter < Formula
  desc "Model Context Protocol runtime and CLI generator"
  homepage "https://github.com/steipete/mcporter"
  url "https://github.com/steipete/mcporter/releases/download/v0.7.3/mcporter-macos-arm64-v0.7.3.tar.gz"
  sha256 "852da8adefeb78df53705aa3af12fe725067c8014a5a57d1d6a3b273d29a7dfe"
  license "MIT"

  depends_on arch: :arm64

  def install
    bin.install "mcporter"
  end

  test do
    assert_match "Usage: mcporter <command>", shell_output("#{bin}/mcporter", 1)
  end
end
