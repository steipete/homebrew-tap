class Gogcli < Formula
  desc "Google CLI for Gmail, Calendar, Drive, and Contacts"
  homepage "https://github.com/steipete/gogcli"
  version "0.10.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/steipete/gogcli/releases/download/v#{version}/gogcli_#{version}_darwin_arm64.tar.gz"
      sha256 "b0d3c30529abe345f5129ce6ed947325f7031d4ee9ef490b1e5d76ff9738fc9f"
    else
      url "https://github.com/steipete/gogcli/releases/download/v#{version}/gogcli_#{version}_darwin_amd64.tar.gz"
      sha256 "ec728259b126f3b7cb7e56a3efc7e0159e01664cd426d29669c95fe327d947c0"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/steipete/gogcli/releases/download/v#{version}/gogcli_#{version}_linux_arm64.tar.gz"
      sha256 "438f3182be3b6c5dce9b79322a6ead9c7f67396f60d049bb8b4a3900484f6515"
    else
      url "https://github.com/steipete/gogcli/releases/download/v#{version}/gogcli_#{version}_linux_amd64.tar.gz"
      sha256 "7fc0d507b2d0a6bce9ac4e88c86bb78d9a3672445712ef458a898c33b2aa215d"
    end
  end

  def install
    bin.install "gog"
  end

  test do
    assert_match "Google CLI", shell_output("#{bin}/gog --help")
  end
end
