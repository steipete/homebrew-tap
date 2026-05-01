# typed: false
# frozen_string_literal: true

class Crabbox < Formula
  desc "Remote Linux test boxes for dirty worktrees and CI hydration"
  homepage "https://github.com/openclaw/crabbox"
  version "0.1.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/openclaw/crabbox/releases/download/v0.1.0/crabbox_0.1.0_darwin_amd64.tar.gz"
      sha256 "6bb24f0f53f70107e7bf0ceb5944c9cf2043ab1d2da6ebb772b67869fe179957"

      define_method(:install) do
        bin.install "crabbox"
      end
    end

    if Hardware::CPU.arm?
      url "https://github.com/openclaw/crabbox/releases/download/v0.1.0/crabbox_0.1.0_darwin_arm64.tar.gz"
      sha256 "81d39cd85cd842ebbe86c048bcdf1cbd0763c7bc10bb9a9a80cb000c46f1d27e"

      define_method(:install) do
        bin.install "crabbox"
      end
    end
  end

  on_linux do
    if Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
      url "https://github.com/openclaw/crabbox/releases/download/v0.1.0/crabbox_0.1.0_linux_amd64.tar.gz"
      sha256 "9e9ac9f9fec3301f3f5d7a5ca03042aadc3fd7eb902720971a18ae07195c0e37"

      define_method(:install) do
        bin.install "crabbox"
      end
    end

    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/openclaw/crabbox/releases/download/v0.1.0/crabbox_0.1.0_linux_arm64.tar.gz"
      sha256 "a76c4ee7c6b5edc3a21933b555f6d5594a71a911c13694fb0b8e00a30947b7c7"

      define_method(:install) do
        bin.install "crabbox"
      end
    end
  end

  test do
    system "#{bin}/crabbox", "--version"
  end
end
