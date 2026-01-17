class Gogcli < Formula
  desc "Google CLI for Gmail, Calendar, Drive, and Contacts"
  homepage "https://github.com/steipete/gogcli"
  version "0.7.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/steipete/gogcli/releases/download/v#{version}/gogcli_#{version}_darwin_arm64.tar.gz"
      sha256 "f50657e3d866c30cbc82a1f5793f573fbc8f0cffee6ca45ffb29332f65eaab13"
    else
      url "https://github.com/steipete/gogcli/releases/download/v#{version}/gogcli_#{version}_darwin_amd64.tar.gz"
      sha256 "0418838d9659847494c3592989da5624e0a89c2d74b8a38cc5cb90f3ae9ca247"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/steipete/gogcli/releases/download/v#{version}/gogcli_#{version}_linux_arm64.tar.gz"
      sha256 "081d53670e3c211b942ce0485eb9f6a476830a6157eeb5f7a75b455fcda9e61c"
    else
      url "https://github.com/steipete/gogcli/releases/download/v#{version}/gogcli_#{version}_linux_amd64.tar.gz"
      sha256 "93e585dc0c8b372d369b2a0ee661bc20b79b09f5b87d220af36f6b762d4afba6"
    end
  end

  def install
    bin.install "gog"
  end

  test do
    assert_match "Google CLI", shell_output("#{bin}/gog --help")
  end
end
