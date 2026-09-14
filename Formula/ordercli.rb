class Ordercli < Formula
  desc "Multi-provider order CLI (Foodora, Deliveroo)"
  homepage "https://github.com/steipete/ordercli"
  version "0.2.1"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/steipete/ordercli/releases/download/v0.2.1/ordercli_0.2.1_darwin_arm64.tar.gz"
      sha256 "a5c9d177caf5ac4f19e69eab445ecf05b2418ea8a1efec21412ad3c4de4f17ec"
    else
      url "https://github.com/steipete/ordercli/releases/download/v0.2.1/ordercli_0.2.1_darwin_amd64.tar.gz"
      sha256 "add7ddb96a64cf85bbcf35d52d35ee67b632aae021530bccd9948b7466ca7d9b"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/steipete/ordercli/releases/download/v0.2.1/ordercli_0.2.1_linux_arm64.tar.gz"
      sha256 "ad58d55b5e7593c4da66643588eee79a29121bdae5dd7a9c9d03bd1b31390d35"
    else
      url "https://github.com/steipete/ordercli/releases/download/v0.2.1/ordercli_0.2.1_linux_amd64.tar.gz"
      sha256 "6727aff064b73783cc04b44ace644696ced331f75624a9f5abb723463adb0fbc"
    end
  end

  def install
    bin.install "ordercli"
  end

  test do
    assert_match "multi-provider order CLI", shell_output("#{bin}/ordercli --help")
  end
end
