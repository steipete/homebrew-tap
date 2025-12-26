class Bird < Formula
  desc "Fast X CLI for tweeting, replying, and reading"
  homepage "https://github.com/steipete/bird"
  url "https://github.com/steipete/bird/releases/download/v0.2.0/bird-macos-universal-v0.2.0.tar.gz"
  sha256 "7a10066b6c3c30507920e2461ccf55b6046bdfb051e9baf69039f19c5f3c24ea"
  license "MIT"
  version "0.2.0"

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
    assert_match "0.2.0", shell_output("#{bin}/bird --version")
  end
end
