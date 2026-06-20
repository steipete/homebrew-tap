class Telecrawl < Formula
  desc "Telegram Desktop archive CLI with encrypted Git backups"
  homepage "https://github.com/openclaw/telecrawl"
  version "0.3.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/openclaw/telecrawl/releases/download/v#{version}/telecrawl_#{version}_darwin_arm64.tar.gz"
      sha256 "456f1dcb1bafe3c7ce994d8142528d34b0ca36324a49af71d3c45c59094f617e"
    else
      url "https://github.com/openclaw/telecrawl/releases/download/v#{version}/telecrawl_#{version}_darwin_amd64.tar.gz"
      sha256 "298e39cad6ea48eef63f529daf7c3a849bf0b22986a13259eb5530c8e17b457f"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/openclaw/telecrawl/releases/download/v#{version}/telecrawl_#{version}_linux_arm64.tar.gz"
      sha256 "195c71bffd8df8165ee4d79a6855189b5ed20994d9d42e6a3e2b36c3adac5629"
    else
      url "https://github.com/openclaw/telecrawl/releases/download/v#{version}/telecrawl_#{version}_linux_amd64.tar.gz"
      sha256 "688a087bd60e0f270dea50a6f8b6af731eab39e676a3ff120175026deaa6b60e"
    end
  end

  def install
    bin.install "telecrawl"
  end

  def caveats
    <<~EOS
      telecrawl reads Telegram Desktop data from:
        ~/Library/Application Support/Telegram Desktop/tdata

      It writes local state to:
        ~/.telecrawl/

      Quick start:
        telecrawl deps install
        telecrawl doctor
        telecrawl import
        telecrawl status
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/telecrawl --version")
  end
end
