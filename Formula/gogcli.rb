class Gogcli < Formula
  desc "Google CLI for Gmail, Calendar, Drive, and Contacts"
  homepage "https://github.com/steipete/gogcli"
  version "0.9.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/steipete/gogcli/releases/download/v#{version}/gogcli_#{version}_darwin_arm64.tar.gz"
      sha256 "3321b4879070490f5e95717f0c70d374f46a981d493040c42e2b4dbd6f62532b"
    else
      url "https://github.com/steipete/gogcli/releases/download/v#{version}/gogcli_#{version}_darwin_amd64.tar.gz"
      sha256 "a89805db7d63cdb30389ffc4077a3f2e38cbe6f110486968b53255046983ba3a"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/steipete/gogcli/releases/download/v#{version}/gogcli_#{version}_linux_arm64.tar.gz"
      sha256 "67a4fb974c34165c60fb7edb613f78a25aa6f0a94a904b6bdc4641a409743f75"
    else
      url "https://github.com/steipete/gogcli/releases/download/v#{version}/gogcli_#{version}_linux_amd64.tar.gz"
      sha256 "28219f4a57478b3c38d5b33cfcb00f53a5943784b96c3b47e6dd877b384c5a13"
    end
  end

  def install
    bin.install "gog"
  end

  test do
    assert_match "Google CLI", shell_output("#{bin}/gog --help")
  end
end
