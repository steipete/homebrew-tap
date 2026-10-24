class Blucli < Formula
  desc "Play, group, and automate BluOS"
  homepage "https://github.com/steipete/blucli"
  version "0.1.9"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/steipete/blucli/releases/download/v0.1.9/blucli_0.1.9_darwin_arm64.tar.gz"
      sha256 "ad5047f081de5b33c654aa7faf8a1026038bba6378628a0b4e580bf2e9aa5c4b"
    else
      url "https://github.com/steipete/blucli/releases/download/v0.1.9/blucli_0.1.9_darwin_amd64.tar.gz"
      sha256 "f4fb2bb79a3a34dbb7c3d84b2dc788365b8bd503b2ec973fd3ad18c239f11bdb"
    end
  end

  on_linux do
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/steipete/blucli/releases/download/v0.1.9/blucli_0.1.9_linux_arm64.tar.gz"
      sha256 "cdc1698015c92fd6284547fd0386a2ddfe6fda251dac043cebd53e0703b4c28e"
    else
      url "https://github.com/steipete/blucli/releases/download/v0.1.9/blucli_0.1.9_linux_amd64.tar.gz"
      sha256 "757083c7bd855d3d448720a25c808804a860187ff61a53227f65bfc732b0e6a8"
    end
  end

  def install
    bin.install "blu"
    prefix.install "LICENSE"
    prefix.install "README.md"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/blu --version")
  end
end
