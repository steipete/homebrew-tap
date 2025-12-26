class Bird < Formula
  desc "Fast X CLI for tweeting, replying, and reading"
  homepage "https://github.com/steipete/bird"
  url "https://github.com/steipete/bird/releases/download/v0.3.0/bird-macos-universal-v0.3.0.tar.gz"
  sha256 "8b64ce93f32562ce823cef0f906d8104c00a39655766ebc441d2a0da7830b7b1"
  license "MIT"
  version "0.3.0"

  def install
    bin.install "bird"
  end

  def caveats
    <<~EOS
      bird uses X/Twitter GraphQL with local cookies by default.

      Quick start:
        bird whoami
        bird read https://x.com/user/status/1234567890123456789
    EOS
  end

  test do
    assert_match "0.3.0", shell_output("#{bin}/bird --version")
  end
end
