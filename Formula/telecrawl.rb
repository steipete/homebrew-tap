class Telecrawl < Formula
  desc "Telegram Desktop archive CLI with encrypted Git backups"
  homepage "https://github.com/openclaw/telecrawl"
  version "0.2.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/openclaw/telecrawl/releases/download/v#{version}/telecrawl_#{version}_darwin_arm64.tar.gz"
      sha256 "ddeeee68d02e66dae388bf555b3cc4a95c05f93f2a7dab2d46e2a1722b72d713"
    else
      url "https://github.com/openclaw/telecrawl/releases/download/v#{version}/telecrawl_#{version}_darwin_amd64.tar.gz"
      sha256 "6c08b0990404a5b7f9c26f6339ec21e746cb038c9e77745b1d21d2a4e03b31a8"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/openclaw/telecrawl/releases/download/v#{version}/telecrawl_#{version}_linux_arm64.tar.gz"
      sha256 "2a75c179db1999d8e7797e4e4abd43d47adb26ca6b22ccfdd51b047f230baf28"
    else
      url "https://github.com/openclaw/telecrawl/releases/download/v#{version}/telecrawl_#{version}_linux_amd64.tar.gz"
      sha256 "c91c743e1759f1ad5c26b05e0feea236b5582215546daa7a19fddf0a556d9d70"
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
