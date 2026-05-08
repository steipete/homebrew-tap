class Wacrawl < Formula
  desc "Read-only WhatsApp Desktop archive CLI"
  homepage "https://github.com/steipete/wacrawl"
  version "0.2.3"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/steipete/wacrawl/releases/download/v#{version}/wacrawl_#{version}_darwin_arm64.tar.gz"
      sha256 "f74e1ae8802cc06e860cdf02dde25363fe17c262eb9c91811b093a3aa912069d"
    else
      url "https://github.com/steipete/wacrawl/releases/download/v#{version}/wacrawl_#{version}_darwin_amd64.tar.gz"
      sha256 "727630d47eea41a432790b54bd3a395ee2c44552617896bb3ff19bc27ed76f66"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/steipete/wacrawl/releases/download/v#{version}/wacrawl_#{version}_linux_arm64.tar.gz"
      sha256 "da6c8b00906639219a940bee4f933c3a1a0e2d2c8b21d446ec72acba47412d8e"
    else
      url "https://github.com/steipete/wacrawl/releases/download/v#{version}/wacrawl_#{version}_linux_amd64.tar.gz"
      sha256 "8a6dda054a2afbf997357672db392f62878166be12abaa4d95c727bcc239d8e5"
    end
  end

  def install
    bin.install "wacrawl"
  end

  def caveats
    <<~EOS
      wacrawl reads WhatsApp Desktop data from:
        ~/Library/Group Containers/group.net.whatsapp.WhatsApp.shared

      It writes its archive to:
        ~/.wacrawl/wacrawl.db

      Quick start:
        wacrawl doctor
        wacrawl import
        wacrawl status
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/wacrawl --version")
  end
end
