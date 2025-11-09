class Mcporter < Formula
  desc "Model Context Protocol runtime and CLI generator"
  homepage "https://github.com/steipete/mcporter"
  url "https://github.com/steipete/mcporter/releases/download/v0.4.2/mcporter-macos-arm64-v0.4.2.tar.gz"
  sha256 "704d2df8b34cfa60c8cc1814b28837f125dad7cc1066568498f3ff8fdecd33b3"
  license "MIT"
  version "0.4.2"

  depends_on arch: :arm64

  def install
    bin.install "mcporter"
  end

  test do
    assert_match "Usage: mcporter <command>", shell_output("#{bin}/mcporter", 1)
  end
end
