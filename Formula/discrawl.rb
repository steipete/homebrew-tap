class Discrawl < Formula
  desc "Discord archive CLI for local SQLite search and analysis"
  homepage "https://github.com/openclaw/discrawl"
  version "0.7.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/openclaw/discrawl/releases/download/v#{version}/discrawl_#{version}_darwin_arm64.tar.gz"
      sha256 "31d8825acd7d18854a7c2b6b4101d4ae47e712f70ba668e6c1163010b55f3250"
    else
      url "https://github.com/openclaw/discrawl/releases/download/v#{version}/discrawl_#{version}_darwin_amd64.tar.gz"
      sha256 "dd2505147fc8444ee0088beafb5c7e0b14f70f4614132a844b5cc14b77b4bc09"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/openclaw/discrawl/releases/download/v#{version}/discrawl_#{version}_linux_arm64.tar.gz"
      sha256 "ca805c5b257abc6ab14eb793784f2ab19299ce4ca58b8d0f2bfd8b163ef61879"
    else
      url "https://github.com/openclaw/discrawl/releases/download/v#{version}/discrawl_#{version}_linux_amd64.tar.gz"
      sha256 "c0bb452032768040fed78f6b5a515a43f05dbfe5a7907ebe7a85975ec23c31c1"
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
