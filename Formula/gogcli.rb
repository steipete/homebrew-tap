class Gogcli < Formula
  desc "Google CLI for Gmail, Calendar, Drive, Docs, Sheets, and more"
  homepage "https://github.com/steipete/gogcli"
  version "0.13.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/steipete/gogcli/releases/download/v#{version}/gogcli_#{version}_darwin_arm64.tar.gz"
      sha256 "7c6f650f7516323ddd003e4ababf998fc1d2c73089a4662b8c79bf80ac4bdf56"
    else
      url "https://github.com/steipete/gogcli/releases/download/v#{version}/gogcli_#{version}_darwin_amd64.tar.gz"
      sha256 "15c88798d25cb2e1870cafa5df232601f3a05472a134ca8c396be907f2b235f6"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/steipete/gogcli/releases/download/v#{version}/gogcli_#{version}_linux_arm64.tar.gz"
      sha256 "1e8af1a03c299855a4e968b72faabefef230f7aee37d2bf366ae92f2e19292d4"
    else
      url "https://github.com/steipete/gogcli/releases/download/v#{version}/gogcli_#{version}_linux_amd64.tar.gz"
      sha256 "a1fe25c47cc3297c6695d61c1b0b3abb7e88634b11e86d77bc0d930377287e3d"
    end
  end

  def install
    bin.install "gog"
  end

  test do
    assert_match "Google CLI", shell_output("#{bin}/gog --help")
  end
end
