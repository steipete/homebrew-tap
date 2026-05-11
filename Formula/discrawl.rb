class Discrawl < Formula
  desc "Discord archive CLI for local SQLite search and analysis"
  homepage "https://github.com/openclaw/discrawl"
  version "0.7.2"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/openclaw/discrawl/releases/download/v#{version}/discrawl_#{version}_darwin_arm64.tar.gz"
      sha256 "f301cc5b6ac497d5d09c623c19b9b2fce62457419965fe3e28ed0d93a2230a2f"
    else
      url "https://github.com/openclaw/discrawl/releases/download/v#{version}/discrawl_#{version}_darwin_amd64.tar.gz"
      sha256 "5584723d432845db3dcd13ee70eabb4c2d3a798401800b8e29fa3e2b85f428c0"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/openclaw/discrawl/releases/download/v#{version}/discrawl_#{version}_linux_arm64.tar.gz"
      sha256 "834446adf35c6e82d2d231f1ecc31d52c390631a87eebf8d25e5d2b308c1c2f5"
    else
      url "https://github.com/openclaw/discrawl/releases/download/v#{version}/discrawl_#{version}_linux_amd64.tar.gz"
      sha256 "fccd8500e56036cb478f87e08652f3fc24a8a75662c42f71122393e38c6cbb3a"
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
