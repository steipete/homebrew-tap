class Gogcli < Formula
  desc "Google CLI for Gmail, Calendar, Drive, Docs, Sheets, and more"
  homepage "https://github.com/openclaw/gogcli"
  version "0.16.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/openclaw/gogcli/releases/download/v0.16.0/gogcli_0.16.0_darwin_arm64.tar.gz"
      sha256 "8d16cfa777c713377b58baec71f6ec7f68ac17baf93724c885cb5f02eac93797"
    else
      url "https://github.com/openclaw/gogcli/releases/download/v0.16.0/gogcli_0.16.0_darwin_amd64.tar.gz"
      sha256 "64cf59eb50707ccad36f7e8b7d62eb2927d81547e034b3893a0ad02fa774c4b2"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/openclaw/gogcli/releases/download/v0.16.0/gogcli_0.16.0_linux_arm64.tar.gz"
      sha256 "a11ca8d92e0162477c23ae901fe36d51f7cebd9e11d0320da4d10584f8235324"
    else
      url "https://github.com/openclaw/gogcli/releases/download/v0.16.0/gogcli_0.16.0_linux_amd64.tar.gz"
      sha256 "46c8ffa71a4e425e6885b926f1c67be7899f444c9e254ae8da9c46ea297a6bda"
    end
  end

  def install
    bin.install "gog"
  end

  test do
    assert_match "Google CLI", shell_output("#{bin}/gog --help")
  end
end
