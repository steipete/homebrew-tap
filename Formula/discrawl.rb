class Discrawl < Formula
  desc "Discord archive CLI for local SQLite search and analysis"
  homepage "https://github.com/openclaw/discrawl"
  version "0.7.1"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/openclaw/discrawl/releases/download/v#{version}/discrawl_#{version}_darwin_arm64.tar.gz"
      sha256 "4f4c4f8f68029331fb0514402c4aab740e17b67c032dfce9b93ae79cdadd8659"
    else
      url "https://github.com/openclaw/discrawl/releases/download/v#{version}/discrawl_#{version}_darwin_amd64.tar.gz"
      sha256 "e6293ad4005824ba7c1807d6b6c2ac82ff7212c36b4e20a9a63acf274c6f0817"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/openclaw/discrawl/releases/download/v#{version}/discrawl_#{version}_linux_arm64.tar.gz"
      sha256 "922c9dd5f4b5c603f71f11f6b9919b6a948d783b4c2577ef7cc3f8c0401936c8"
    else
      url "https://github.com/openclaw/discrawl/releases/download/v#{version}/discrawl_#{version}_linux_amd64.tar.gz"
      sha256 "9eec085f0da0a096cd849b1c186e5a36f0bf6b734875f399d5521fca160a2194"
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
