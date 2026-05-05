class Gogcli < Formula
  desc "Google CLI for Gmail, Calendar, Drive, Docs, Sheets, and more"
  homepage "https://github.com/steipete/gogcli"
  version "0.15.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/steipete/gogcli/releases/download/v#{version}/gogcli_#{version}_darwin_arm64.tar.gz"
      sha256 "58c73d9e9ad9fb69ba35df8c69b0f97865c9d974a6a5115f1bb46e23f2dd97c9"
    else
      url "https://github.com/steipete/gogcli/releases/download/v#{version}/gogcli_#{version}_darwin_amd64.tar.gz"
      sha256 "a30565faf525bfcd0dd36455bcff625b39c45e52e0f1d975ca0df25a3177a015"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/steipete/gogcli/releases/download/v#{version}/gogcli_#{version}_linux_arm64.tar.gz"
      sha256 "477f83515957f5ab0a0dcf41fcd485483175d4fb18e0ed6165766c310b2a1b35"
    else
      url "https://github.com/steipete/gogcli/releases/download/v#{version}/gogcli_#{version}_linux_amd64.tar.gz"
      sha256 "bfa2a9c8092bd329db89aa100f8074a3f14251e3db716b927627793e47148c9d"
    end
  end

  def install
    bin.install "gog"
  end

  test do
    assert_match "Google CLI", shell_output("#{bin}/gog --help")
  end
end
