class Bird < Formula
  desc "Fast X CLI for tweeting, replying, and reading"
  homepage "https://github.com/steipete/bird"
  url "https://github.com/steipete/bird/releases/download/v0.1.0/bird-macos-universal-v0.1.0.tar.gz"
  sha256 "55b68e41f004e3ade4cdafaa5e650af600f30a37ad1995ee0d91a96823b58a95"
  license "MIT"
  version "0.1.0"

  def install
    bin.install "bird"
  end

  def caveats
    <<~EOS
      bird uses X/Twitter GraphQL with local cookies by default.
      Sweetistics API mode is available with SWEETISTICS_API_KEY.

      Quick start:
        bird whoami
        bird read https://x.com/user/status/1234567890123456789
    EOS
  end

  test do
    assert_match "0.1.0", shell_output("#{bin}/bird --version")
  end
end
