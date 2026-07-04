require "language/node"

class Birdclaw < Formula
  desc "Local Twitter memory for archives, DMs, likes, bookmarks, and moderation"
  homepage "https://github.com/steipete/birdclaw"
  url "https://registry.npmjs.org/birdclaw/-/birdclaw-0.9.2.tgz"
  sha256 "f3321ea1b475ec4e8a2cf9639a231ddca6eba926bf509ca4092c3b8cdbb7048f"
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
