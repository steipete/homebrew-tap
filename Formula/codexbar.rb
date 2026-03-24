class Codexbar < Formula
  desc "CodexBar CLI for usage/status output"
  homepage "https://github.com/steipete/CodexBar"
  version "0.19.0"
  license "MIT"

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/steipete/CodexBar/releases/download/v#{version}/CodexBarCLI-v#{version}-linux-aarch64.tar.gz"
      sha256 "36d3fb745174cb42699d93ac40787ffddb55482b00e9ec2ce4cf01f8ad0494f4"
    else
      url "https://github.com/steipete/CodexBar/releases/download/v#{version}/CodexBarCLI-v#{version}-linux-x86_64.tar.gz"
      sha256 "7c048b3d2db81103a064d6d5dc3e5ee60f195ae773cac0438055c4f9fc4f6583"
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
