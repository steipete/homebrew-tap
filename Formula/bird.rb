class Bird < Formula
  desc "Fast X CLI for tweeting, replying, and reading"
  homepage "https://github.com/steipete/bird"
  url "https://github.com/steipete/bird/releases/download/v0.7.0/bird-macos-universal-v0.7.0.tar.gz"
  sha256 "5e8d0bd15cc5e4438d3fd025998cdce7da91d7193d1d268b15f031ada9d2d30d"
  license "MIT"

  def install
    bin.install "bird"
  end

  def caveats
    <<~EOS
      bird uses X/Twitter GraphQL with local cookies by default.
      This is an undocumented/private API and can break whenever X changes things.

      Quick start:
        bird whoami
        bird read https://x.com/user/status/1234567890123456789
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/bird --version")
  end
end
