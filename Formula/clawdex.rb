class Clawdex < Formula
  desc "Local-first personal contact index CLI backed by Markdown and Git"
  homepage "https://github.com/openclaw/clawdex"
  version "0.1.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/openclaw/clawdex/releases/download/v#{version}/clawdex_#{version}_darwin_arm64.tar.gz"
      sha256 "11ee3d3e4c69ad4f296244a67890266f73624396c792744e020dd370fd311d3b"
    else
      url "https://github.com/openclaw/clawdex/releases/download/v#{version}/clawdex_#{version}_darwin_amd64.tar.gz"
      sha256 "c292bbc5cb9ea871a80a86bc26f1a1b99fa1c5b3ad3fea84693ee672f14cd05b"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/openclaw/clawdex/releases/download/v#{version}/clawdex_#{version}_linux_arm64.tar.gz"
      sha256 "c7cf20af9746212be1ecf4840b06d45de0346a549d78eacb0aa669f092af66ef"
    else
      url "https://github.com/openclaw/clawdex/releases/download/v#{version}/clawdex_#{version}_linux_amd64.tar.gz"
      sha256 "5e4f42cc94233af76dc9c8c8f964acdd457e7126530198fdde335dbc02c806b2"
    end
  end

  def install
    bin.install "clawdex"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/clawdex --version")
  end
end
