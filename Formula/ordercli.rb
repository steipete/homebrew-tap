class Ordercli < Formula
  desc "Multi-provider order CLI (Foodora, Deliveroo)"
  homepage "https://github.com/steipete/ordercli"
  version "0.1.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/steipete/ordercli/releases/download/v#{version}/ordercli_#{version}_darwin_arm64.tar.gz"
      sha256 "79935b51987329bf8df069ce39d6578044b33b304e3c0d5bc0b85c8f15f03ee8"
    else
      url "https://github.com/steipete/ordercli/releases/download/v#{version}/ordercli_#{version}_darwin_amd64.tar.gz"
      sha256 "10fb1e9cc4025d8ec7b584af577e17c5fcfa58fec23f3b9e03f18716f6ba5ff8"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/steipete/ordercli/releases/download/v#{version}/ordercli_#{version}_linux_arm64.tar.gz"
      sha256 "d4b48f6dc614e5a709f03b33f42c388d32d234f766dd2bd1d4dbb93a29cae888"
    else
      url "https://github.com/steipete/ordercli/releases/download/v#{version}/ordercli_#{version}_linux_amd64.tar.gz"
      sha256 "6793d65f60e3a143d37f6c6b87b49c5ad50d474ff25a063ef1e2cc5ca159316b"
    end
  end

  def install
    bin.install "ordercli"
  end

  test do
    assert_match "multi-provider order CLI", shell_output("#{bin}/ordercli --help")
  end
end
