class Wacrawl < Formula
  desc "Read-only WhatsApp Desktop archive CLI"
  homepage "https://github.com/steipete/wacrawl"
  version "0.2.2"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/steipete/wacrawl/releases/download/v#{version}/wacrawl_#{version}_darwin_arm64.tar.gz"
      sha256 "b7b6891319335cc201d1d8bb742cf841f57d9fb45816e4ab09ba81dc81703966"
    else
      url "https://github.com/steipete/wacrawl/releases/download/v#{version}/wacrawl_#{version}_darwin_amd64.tar.gz"
      sha256 "1798ecbd079c23dea4051b846d3b5992809a691062c57d7cab52fe8ec2847ff2"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/steipete/wacrawl/releases/download/v#{version}/wacrawl_#{version}_linux_arm64.tar.gz"
      sha256 "4ce962833da32854e184b325862f2fd65f0b59a90ee86022f120d7b2020f720f"
    else
      url "https://github.com/steipete/wacrawl/releases/download/v#{version}/wacrawl_#{version}_linux_amd64.tar.gz"
      sha256 "4ec50c67e125141dc9034effa66a0a8b9677687c7cc1a01fb48a332d0ebbe320"
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
