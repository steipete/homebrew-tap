class Ordercli < Formula
  desc "Multi-provider order CLI (Foodora, Deliveroo)"
  homepage "https://github.com/steipete/ordercli"
  version "0.2.2"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/steipete/ordercli/releases/download/v0.2.2/ordercli_0.2.2_darwin_arm64.tar.gz"
      sha256 "808933b0d86262f5ab36631757614e56dd60670eab8a97b4d15abda6afe20fef"
    else
      url "https://github.com/steipete/ordercli/releases/download/v0.2.2/ordercli_0.2.2_darwin_amd64.tar.gz"
      sha256 "fc70f0915876ec0401eb7662572258f0c8071b9bace09776c553e81f0bc6b922"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/steipete/ordercli/releases/download/v0.2.2/ordercli_0.2.2_linux_arm64.tar.gz"
      sha256 "9415b8f75eb6f8d1a517ccff21196629136487d82bec0072eef8b532d6888790"
    else
      url "https://github.com/steipete/ordercli/releases/download/v0.2.2/ordercli_0.2.2_linux_amd64.tar.gz"
      sha256 "0d74d7660c304f5ed67957520be24597c2856d6149be681674e8e2e7c521485b"
    end
  end

  def install
    bin.install "ordercli"
  end

  test do
    assert_match "multi-provider order CLI", shell_output("#{bin}/ordercli --help")
  end
end
