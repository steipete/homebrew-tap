class Ordercli < Formula
  desc "Multi-provider order CLI (Foodora, Deliveroo)"
  homepage "https://github.com/steipete/ordercli"
  version "0.2.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/steipete/ordercli/releases/download/v#{version}/ordercli_#{version}_darwin_arm64.tar.gz"
      sha256 "aaf3514dd6d66502ad4f2839f221428400167e02d1c10fdc0d0570654aab592a"
    else
      url "https://github.com/steipete/ordercli/releases/download/v#{version}/ordercli_#{version}_darwin_amd64.tar.gz"
      sha256 "0d0cf3d6e4487d0072e144f5c631915e5cfbf268834eb10b1ff6ec9037ae4a05"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/steipete/ordercli/releases/download/v#{version}/ordercli_#{version}_linux_arm64.tar.gz"
      sha256 "469bac817589e23e7f4767899c9faff42aa3814ad5deb12d94ac5fd17858a9dc"
    else
      url "https://github.com/steipete/ordercli/releases/download/v#{version}/ordercli_#{version}_linux_amd64.tar.gz"
      sha256 "81f79eca75bfd2e4db02d58da79f85279a9703ff66d9b9c328542eaa1bb798ac"
    end
  end

  def install
    bin.install "ordercli"
  end

  test do
    assert_match "multi-provider order CLI", shell_output("#{bin}/ordercli --help")
  end
end
