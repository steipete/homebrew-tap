class Bird < Formula
  desc "Fast X CLI for tweeting, replying, and reading"
  homepage "https://github.com/steipete/bird"
  url "https://github.com/steipete/bird/releases/download/v0.6.0/bird-macos-universal-v0.6.0.tar.gz"
  sha256 "1ddbf234192af7a454afbbcdb431efa9b2afe7bc3f4952d5dc05a26a231439da"
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
