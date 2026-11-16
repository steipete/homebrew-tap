class Ordercli < Formula
  desc "Multi-provider order CLI (Foodora, Deliveroo)"
  homepage "https://github.com/steipete/ordercli"
  version "0.2.4"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/steipete/ordercli/releases/download/v0.2.4/ordercli_0.2.4_darwin_arm64.tar.gz"
      sha256 "9bd9ea5dae490b56ecc0e6f5a4cbe7a35772465507fd3cbd208b254a07aa146a"
    else
      url "https://github.com/steipete/ordercli/releases/download/v0.2.4/ordercli_0.2.4_darwin_amd64.tar.gz"
      sha256 "bc755387b5ec84fd1dd4faaadb4f7342ad85570ded86bd07b69fadd927201508"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/steipete/ordercli/releases/download/v0.2.4/ordercli_0.2.4_linux_arm64.tar.gz"
      sha256 "9957ab867fb06d459adfde2da46342a93f9e7d42890d708befc232e5ff7b217c"
    else
      url "https://github.com/steipete/ordercli/releases/download/v0.2.4/ordercli_0.2.4_linux_amd64.tar.gz"
      sha256 "34a026186b81ed090668e44ca4960a9fb9358d5adb754c083eeb57795ffded61"
    end
  end

  def install
    bin.install "ordercli"
  end

  test do
    assert_match "multi-provider order CLI", shell_output("#{bin}/ordercli --help")
  end
end
