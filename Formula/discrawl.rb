class Discrawl < Formula
  desc "Discord archive CLI for local SQLite search and analysis"
  homepage "https://github.com/steipete/discrawl"
  version "0.6.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/steipete/discrawl/releases/download/v#{version}/discrawl_#{version}_darwin_arm64.tar.gz"
      sha256 "540183da699b64fde9c4182dce0f67dc313cf4d0cb283e6250854c6c963068ea"
    else
      url "https://github.com/steipete/discrawl/releases/download/v#{version}/discrawl_#{version}_darwin_amd64.tar.gz"
      sha256 "576e944e87c3b6d6679df0a2d8bb873e0211b1b79fba7c9c8af8341ccab9c46a"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/steipete/discrawl/releases/download/v#{version}/discrawl_#{version}_linux_arm64.tar.gz"
      sha256 "dae450a27acce131e24b23548abf5b80ec9a4d61db3efe1bac83c2356e32538b"
    else
      url "https://github.com/steipete/discrawl/releases/download/v#{version}/discrawl_#{version}_linux_amd64.tar.gz"
      sha256 "290969c3f2356ac04ae3edc895b0a23bbebecac248315492bb0aabafd506d7dd"
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
