require "language/node"

class Birdclaw < Formula
  desc "Local Twitter memory for archives, DMs, likes, bookmarks, and moderation"
  homepage "https://github.com/steipete/birdclaw"
  url "https://registry.npmjs.org/birdclaw/-/birdclaw-0.5.1.tgz"
  sha256 "e7f6ce07cbd0e375fea26ac7f65df3167cfeafa5add29001d6362f3438197f45"
  license "MIT"

  depends_on "node"

  def install
    system "npm", "install", *std_npm_args, "--min-release-age=0"
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

      Optional live Twitter reads and writes use xurl.
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/birdclaw --version")
    assert_match "Local-first Twitter workspace", shell_output("#{bin}/birdclaw --help")
  end
end
