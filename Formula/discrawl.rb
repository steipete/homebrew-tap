class Discrawl < Formula
  desc "Discord archive CLI for local SQLite search and analysis"
  homepage "https://github.com/steipete/discrawl"
  version "0.6.6"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/steipete/discrawl/releases/download/v#{version}/discrawl_#{version}_darwin_arm64.tar.gz"
      sha256 "d04eb0b17ae68540a2ed0390f4ef4041354baa8c36577c6d3d8e692eef6d6e51"
    else
      url "https://github.com/steipete/discrawl/releases/download/v#{version}/discrawl_#{version}_darwin_amd64.tar.gz"
      sha256 "6cda3cfe848b34d3fc29c8f8d3bb62779cb27d35716a05246ca119758f5b601f"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/steipete/discrawl/releases/download/v#{version}/discrawl_#{version}_linux_arm64.tar.gz"
      sha256 "ac41c8d4bb7a1192c879d6f6c380466c10d151ae14319aa62fa9d35d0e147e5c"
    else
      url "https://github.com/steipete/discrawl/releases/download/v#{version}/discrawl_#{version}_linux_amd64.tar.gz"
      sha256 "0447dee10ca6aadf36f3818923ac2abc53ee5808c1a0bac05e9528d177e15d41"
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
