class Discrawl < Formula
  desc "Discord archive CLI for local SQLite search and analysis"
  homepage "https://github.com/steipete/discrawl"
  version "0.6.1"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/steipete/discrawl/releases/download/v#{version}/discrawl_#{version}_darwin_arm64.tar.gz"
      sha256 "365dec2366cd7ced464346a3d0e2a5b67e2e618d0376b7edb6616529cda5df0c"
    else
      url "https://github.com/steipete/discrawl/releases/download/v#{version}/discrawl_#{version}_darwin_amd64.tar.gz"
      sha256 "6394a20ff6c0ae32033eb1b5b2c5640083780267c40e1b41913055d30934e568"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/steipete/discrawl/releases/download/v#{version}/discrawl_#{version}_linux_arm64.tar.gz"
      sha256 "898a42018a71fa38094ab9abc17002b21b238d1780979f9761a5606b60662d03"
    else
      url "https://github.com/steipete/discrawl/releases/download/v#{version}/discrawl_#{version}_linux_amd64.tar.gz"
      sha256 "81a8b44e9229fbfd3a25045a4c4de19508012ecd78159f005c55cc4cf69aa112"
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
