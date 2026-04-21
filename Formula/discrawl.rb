class Discrawl < Formula
  desc "Discord archive CLI for local SQLite search and analysis"
  homepage "https://github.com/steipete/discrawl"
  version "0.3.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/steipete/discrawl/releases/download/v#{version}/discrawl_#{version}_darwin_arm64.tar.gz"
      sha256 "8a977f54aa2c3b28eb823255d53edafb4cc5cc2e23131d70b944422286e7c7f9"
    else
      url "https://github.com/steipete/discrawl/releases/download/v#{version}/discrawl_#{version}_darwin_amd64.tar.gz"
      sha256 "cf0ed091bc9f9d7d99ea46738f36bdbfca318203f289c20280d48217fc62f055"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/steipete/discrawl/releases/download/v#{version}/discrawl_#{version}_linux_arm64.tar.gz"
      sha256 "ec98379d1b72aa78d4339b18804ce01307d35ae373bf9a389a2f7a816cf17923"
    else
      url "https://github.com/steipete/discrawl/releases/download/v#{version}/discrawl_#{version}_linux_amd64.tar.gz"
      sha256 "3774efa37848f423123efe24ceaa9661359d156425ca92d6aadc8fa67f7a80b6"
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
