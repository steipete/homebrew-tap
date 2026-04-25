class Wacrawl < Formula
  desc "Read-only WhatsApp Desktop archive CLI"
  homepage "https://github.com/steipete/wacrawl"
  version "0.1.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/steipete/wacrawl/releases/download/v#{version}/wacrawl_#{version}_darwin_arm64.tar.gz"
      sha256 "189c3644e0edae7d6e39d76eabd9526005b35d591240f301ba2c1ec82c28bfa8"
    else
      url "https://github.com/steipete/wacrawl/releases/download/v#{version}/wacrawl_#{version}_darwin_amd64.tar.gz"
      sha256 "2c2d1a694995213ff2dab5e93f7f9da40089eb56193f8a2b1dee62ac3e083297"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/steipete/wacrawl/releases/download/v#{version}/wacrawl_#{version}_linux_arm64.tar.gz"
      sha256 "4326ca685d659aa1950d4c2a04b59f12d270913fc107d2ac2602f56bf9b8d214"
    else
      url "https://github.com/steipete/wacrawl/releases/download/v#{version}/wacrawl_#{version}_linux_amd64.tar.gz"
      sha256 "70c3661ff5e3fbee5d0088a9855cfb7bb0d80f0336c71f9194457104ac3b909c"
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
