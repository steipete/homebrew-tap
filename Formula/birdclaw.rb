require "language/node"

class Birdclaw < Formula
  desc "Local Twitter memory for archives, DMs, likes, bookmarks, and moderation"
  homepage "https://github.com/steipete/birdclaw"
  url "https://registry.npmjs.org/birdclaw/-/birdclaw-0.2.1.tgz"
  sha256 "3eefe164cdff72897f286308fd671d86f1dbabad4ca8e87bb421bac166dfeb5b"
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

      Optional live Twitter reads and writes use xurl.
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/birdclaw --version")
    assert_match "Local-first Twitter workspace", shell_output("#{bin}/birdclaw --help")
  end
end
