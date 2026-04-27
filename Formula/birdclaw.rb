require "language/node"

class Birdclaw < Formula
  desc "Local-first X workspace for archives, DMs, mentions, and moderation"
  homepage "https://github.com/steipete/birdclaw"
  url "https://registry.npmjs.org/birdclaw/-/birdclaw-0.1.1.tgz"
  sha256 "88f99b43991422119035b4da33c87b0baa203f588beec6f2f0545d3e33c5e8b9"
  license "MIT"

  depends_on "node"

  def install
    system "npm", "install", *std_npm_args
    cd libexec/"lib/node_modules/birdclaw" do
      system "npm", "rebuild", "better-sqlite3", "--build-from-source"
    end
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
