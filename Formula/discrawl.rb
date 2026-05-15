class Discrawl < Formula
  desc "Discord archive CLI for local SQLite search and analysis"
  homepage "https://github.com/openclaw/discrawl"
  version "0.8.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/openclaw/discrawl/releases/download/v#{version}/discrawl_#{version}_darwin_arm64.tar.gz"
      sha256 "4f9542b71761eb02c4cb750ea325ab5cc29576f58334428386f7baa5fd820ec1"
    else
      url "https://github.com/openclaw/discrawl/releases/download/v#{version}/discrawl_#{version}_darwin_amd64.tar.gz"
      sha256 "e2a161226b8e12be38e564b0137f81a458fe5eca6d9d6ef42f3788e52282fe9e"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/openclaw/discrawl/releases/download/v#{version}/discrawl_#{version}_linux_arm64.tar.gz"
      sha256 "de25d4b5bf11e8aebc65c7f1c6a728cd7e7cd388a6ebca401cfd47983de3b8be"
    else
      url "https://github.com/openclaw/discrawl/releases/download/v#{version}/discrawl_#{version}_linux_amd64.tar.gz"
      sha256 "d2cc832cb22076fd9c045ef53e0c43c40e1ca86ef19f0fe6d9fa4e33a9d3f536"
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

      Git-only readers can set:
        token_source = "none"
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/discrawl --version")
  end
end
