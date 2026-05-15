class Gogcli < Formula
  desc "Google CLI for Gmail, Calendar, Drive, Docs, Sheets, and more"
  homepage "https://github.com/openclaw/gogcli"
  version "0.17.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/openclaw/gogcli/releases/download/v0.17.0/gogcli_0.17.0_darwin_arm64.tar.gz"
      sha256 "ae5fe6723f9252dcfcd311643eb7fc8c3fc7c5a0c17d4e8bad56f309b20bfcdf"
    else
      url "https://github.com/openclaw/gogcli/releases/download/v0.17.0/gogcli_0.17.0_darwin_amd64.tar.gz"
      sha256 "1d8db0d4c8cdfb2b1fdb27a84218a5bc7409bc62ec1b49fef9d83dbdc6ac7c50"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/openclaw/gogcli/releases/download/v0.17.0/gogcli_0.17.0_linux_arm64.tar.gz"
      sha256 "62f6cfc20b888aceb711f90a5193d7bdfd5def94a61cc5e1e99a0a0c7082b8a7"
    else
      url "https://github.com/openclaw/gogcli/releases/download/v0.17.0/gogcli_0.17.0_linux_amd64.tar.gz"
      sha256 "b846c4651914fa00c3497716eb39bb67e7ab149e54bcd2dc98367bf5e0f790d7"
    end
  end

  def install
    bin.install "gog"
  end

  test do
    assert_match "Google CLI", shell_output("#{bin}/gog --help")
  end
end
