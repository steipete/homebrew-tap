class Wacrawl < Formula
  desc "Read-only WhatsApp Desktop archive CLI"
  homepage "https://github.com/steipete/wacrawl"
  version "0.2.1"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/steipete/wacrawl/releases/download/v#{version}/wacrawl_#{version}_darwin_arm64.tar.gz"
      sha256 "d4219583fcf35bfdd5ea8b8de6edac06c489075c4eff54b625c81c96a9ee1f34"
    else
      url "https://github.com/steipete/wacrawl/releases/download/v#{version}/wacrawl_#{version}_darwin_amd64.tar.gz"
      sha256 "4cdaa881d260f3803c7b1c851153bf796c40144aa3678438bdaeb6aa6a6f2044"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/steipete/wacrawl/releases/download/v#{version}/wacrawl_#{version}_linux_arm64.tar.gz"
      sha256 "365c859149d05ba3d604092e0398f99b226355f46f75bdf06da6e7b1bd46038c"
    else
      url "https://github.com/steipete/wacrawl/releases/download/v#{version}/wacrawl_#{version}_linux_amd64.tar.gz"
      sha256 "466b0801d6d269f50cb57d607764b493acc0506140a517e8373a30f6d0f1427a"
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
