class Discrawl < Formula
  desc "Discord archive CLI for local SQLite search and analysis"
  homepage "https://github.com/steipete/discrawl"
  version "0.5.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/steipete/discrawl/releases/download/v#{version}/discrawl_#{version}_darwin_arm64.tar.gz"
      sha256 "a5c0058e4f82d98a77ad09b6da31fc0e9be0ba86bc5ed51a745e98ed71ea0c1e"
    else
      url "https://github.com/steipete/discrawl/releases/download/v#{version}/discrawl_#{version}_darwin_amd64.tar.gz"
      sha256 "d4a648e0c730a50eb25686bc5f3c1a48805a02a697b3a8a632ab239afa6414b2"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/steipete/discrawl/releases/download/v#{version}/discrawl_#{version}_linux_arm64.tar.gz"
      sha256 "59d9e056d912754d8f0ab475aeea67a4bc46e19c07ed1fe9d15f23123843cffb"
    else
      url "https://github.com/steipete/discrawl/releases/download/v#{version}/discrawl_#{version}_linux_amd64.tar.gz"
      sha256 "dd4566b987bbd8dd347fa1c6ee0e307af1b8d1bc7aba3de191f7552403037ce0"
    end
  end

  def install
    bin.install "discrawl"
  end

  def caveats
    <<~EOS
      discrawl stores local state under:
        ~/.discrawl/config.toml
        ~/.discrawl/discrawl.db

      Fastest setup:
        export DISCORD_BOT_TOKEN="your-bot-token"
        discrawl doctor
        discrawl init
        discrawl sync --full

      If you already use OpenClaw, discrawl can reuse:
        ~/.openclaw/openclaw.json
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/discrawl --version")
  end
end
