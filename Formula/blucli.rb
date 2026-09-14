class Blucli < Formula
  desc "Play, group, and automate BluOS"
  homepage "https://github.com/steipete/blucli"
  version "0.1.7"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/steipete/blucli/releases/download/v0.1.7/blucli_0.1.7_darwin_arm64.tar.gz"
      sha256 "4a7305d991e5d0bdc2eaac752bee5e9921bba787f2649e6f04340b0c407f5507"
    else
      url "https://github.com/steipete/blucli/releases/download/v0.1.7/blucli_0.1.7_darwin_amd64.tar.gz"
      sha256 "98c3b0f0873e41f023c7c95cd1069b597bd6e5c376939d15df52fe42e50cfc5e"
    end
  end

  on_linux do
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/steipete/blucli/releases/download/v0.1.7/blucli_0.1.7_linux_arm64.tar.gz"
      sha256 "ccd2fe4005187b4ad07744b4e4bd571cf47585005065c3b8547dbb332cda5939"
    else
      url "https://github.com/steipete/blucli/releases/download/v0.1.7/blucli_0.1.7_linux_amd64.tar.gz"
      sha256 "436c4fc1960145709f48147a99670147fa1b77f0662002f7da4979cdb0dce0cb"
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
