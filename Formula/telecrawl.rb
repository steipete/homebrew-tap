class Telecrawl < Formula
  desc "Telegram Desktop archive CLI with encrypted Git backups"
  homepage "https://github.com/openclaw/telecrawl"
  version "0.1.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/openclaw/telecrawl/releases/download/v#{version}/telecrawl_#{version}_darwin_arm64.tar.gz"
      sha256 "d62c7affeec36aac7d2add791079928dcff276bcbd0bb3f23df049438707e463"
    else
      url "https://github.com/openclaw/telecrawl/releases/download/v#{version}/telecrawl_#{version}_darwin_amd64.tar.gz"
      sha256 "27d40ba18c18299105520bbc839fefb58e089ff20ccc09336ffd3e17b5047483"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/openclaw/telecrawl/releases/download/v#{version}/telecrawl_#{version}_linux_arm64.tar.gz"
      sha256 "8bebc7938317f992e8fc1a97aac73e73c846651d068b42b491b00cbaf5ed8d96"
    else
      url "https://github.com/openclaw/telecrawl/releases/download/v#{version}/telecrawl_#{version}_linux_amd64.tar.gz"
      sha256 "5250e116b9dbeeadc3816073174255f9eba1b8d65ef1bcaf0334413f8bba9bf0"
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
