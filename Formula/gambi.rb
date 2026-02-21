class Gambi < Formula
  desc "Local MCP aggregator with execute-first workflow and OAuth refresh"
  homepage "https://github.com/victorarias/gambi"
  version "0.1.0"
  license "GPL-3.0-only"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/victorarias/gambi/releases/download/v0.1.0/gambi-aarch64-apple-darwin.tar.gz"
      sha256 "5c1d7703274cc8797ae83a55809be59429d422369c32f2988491d767a226826a"
    else
      url "https://github.com/victorarias/gambi/releases/download/v0.1.0/gambi-x86_64-apple-darwin.tar.gz"
      sha256 "e0400f499063b00fc73f3360ba1d409f4b3caa3600064510b33587fcae10c2fa"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/victorarias/gambi/releases/download/v0.1.0/gambi-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "b9d191a4db07d57ad886c3fdda98a55716ab9b10739c4475c4ab384bc35642ca"
    else
      url "https://github.com/victorarias/gambi/releases/download/v0.1.0/gambi-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "526b8a5937cd59fa3b210db84f2062d0c1b634c757b02b0ef6ca15018d7960e9"
    end
  end

  def install
    bin.install "gambi"
    prefix.install "LICENSE"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/gambi --version")
  end
end
