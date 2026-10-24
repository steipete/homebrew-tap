class Ordercli < Formula
  desc "Multi-provider order CLI (Foodora, Deliveroo)"
  homepage "https://github.com/steipete/ordercli"
  version "0.2.3"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/steipete/ordercli/releases/download/v0.2.3/ordercli_0.2.3_darwin_arm64.tar.gz"
      sha256 "44e0a796a038e65c794bd29c11c0ceb514ad5698f26d2139fe7c5cf9d4c1ad32"
    else
      url "https://github.com/steipete/ordercli/releases/download/v0.2.3/ordercli_0.2.3_darwin_amd64.tar.gz"
      sha256 "5fffa3ac530dee074ce110a4a6ad7cc8539b87046646c48bc1234c836b58fd86"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/steipete/ordercli/releases/download/v0.2.3/ordercli_0.2.3_linux_arm64.tar.gz"
      sha256 "b1b63b5097d861a207fc1bef72aeb81eca8a036b613c12283a7ed659851ef8a6"
    else
      url "https://github.com/steipete/ordercli/releases/download/v0.2.3/ordercli_0.2.3_linux_amd64.tar.gz"
      sha256 "52bafb42a3f5599f05bfe03c6d5b0a99cc9d42ed15f918c17e10ee0b58250d1e"
    end
  end

  def install
    bin.install "ordercli"
  end

  test do
    assert_match "multi-provider order CLI", shell_output("#{bin}/ordercli --help")
  end
end
