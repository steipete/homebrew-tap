require "language/node"

class Birdclaw < Formula
  desc "Local-first X workspace for archives, DMs, mentions, and moderation"
  homepage "https://github.com/steipete/birdclaw"
  url "https://registry.npmjs.org/birdclaw/-/birdclaw-0.1.0.tgz"
  sha256 "85a834687a2c7ffec0d3c72bbc6ae8ae78d84a05187786f8fd2e63d0d69cfb94"
  license "MIT"

  depends_on "node"

  def install
    system "npm", "install", *std_npm_args
    bin.install_symlink Dir["#{libexec}/bin/*"]
  end

  def caveats
    <<~EOS
      birdclaw stores local state under:
        ~/.birdclaw/birdclaw.sqlite
        ~/.birdclaw/config.json
        ~/.birdclaw/media

      Quick start:
        birdclaw init
        birdclaw auth status --json
        birdclaw db stats --json

      Optional live X reads and writes use xurl.
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/birdclaw --version")
    assert_match "Local-first X workspace", shell_output("#{bin}/birdclaw --help")
  end
end
