class Bird < Formula
  desc "Fast X CLI for tweeting, replying, and reading"
  homepage "https://github.com/steipete/bird"
  url "https://github.com/steipete/bird/releases/download/v0.4.0/bird-macos-universal-v0.4.0.tar.gz"
  sha256 "51f82698414b14cc2237ec3fcdcfa4f39df3e1ff4476f6b2190bc073c6bc6365"
  license "MIT"
  version "0.4.0"

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
    assert_match "0.4.0", shell_output("#{bin}/bird --version")
  end
end
