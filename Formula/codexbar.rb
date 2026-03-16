class Codexbar < Formula
  desc "CodexBar CLI for usage/status output"
  homepage "https://github.com/steipete/CodexBar"
  version "0.18.0"
  license "MIT"

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/steipete/CodexBar/releases/download/v#{version}/CodexBarCLI-v#{version}-linux-aarch64.tar.gz"
      sha256 "601fc75bd911ebb5ce3acc863e534a4e04b000398e6851af3e18978e4a81792b"
    else
      url "https://github.com/steipete/CodexBar/releases/download/v#{version}/CodexBarCLI-v#{version}-linux-x86_64.tar.gz"
      sha256 "622f26303591a5901604fa5b1bab155149e6f7f99c5084b360608d714c5b0642"
    end
  end

  def install
    bin.install "CodexBarCLI"
    bin.install_symlink "CodexBarCLI" => "codexbar"
  end

  test do
    assert_match "CodexBarCLI", shell_output("#{bin}/codexbar --version")
  end
end
