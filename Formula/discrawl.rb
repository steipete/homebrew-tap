class Discrawl < Formula
  desc "Discord archive CLI for local SQLite search and analysis"
  homepage "https://github.com/openclaw/discrawl"
  version "0.9.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/openclaw/discrawl/releases/download/v#{version}/discrawl_#{version}_darwin_arm64.tar.gz"
      sha256 "07a01692d1622175f9b8ba12563752b2d9a60ec2b0b0afca7b6cdbec3b025c16"
    else
      url "https://github.com/openclaw/discrawl/releases/download/v#{version}/discrawl_#{version}_darwin_amd64.tar.gz"
      sha256 "56c50f258b2402915d00b1973497bf830af262ce35b4b4016745f0456b0481b4"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/openclaw/discrawl/releases/download/v#{version}/discrawl_#{version}_linux_arm64.tar.gz"
      sha256 "713205fcdfbcec22b4cb197a5acab2736b1621e90e2470ab03f25845ed906fc2"
    else
      url "https://github.com/openclaw/discrawl/releases/download/v#{version}/discrawl_#{version}_linux_amd64.tar.gz"
      sha256 "84834c060f6bc8d8219e3f89b2e1945a60e393fd206ee27fe74a85b3f1cdc17b"
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
