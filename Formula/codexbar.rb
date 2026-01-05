class Codexbar < Formula
  desc "CodexBar CLI for usage/status output"
  homepage "https://github.com/steipete/CodexBar"
  version "0.17.0"
  license "MIT"

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/steipete/CodexBar/releases/download/v#{version}/CodexBarCLI-v#{version}-linux-aarch64.tar.gz"
      sha256 "7b86ee04473b85108773ade40127f723e1811d38a85eefcab2bb2a06728cd006"
    else
      url "https://github.com/steipete/CodexBar/releases/download/v#{version}/CodexBarCLI-v#{version}-linux-x86_64.tar.gz"
      sha256 "9bf9bb6fbd33ed1a3c23767e9dad8801318f6722e86aaa0437400a37c12bfbdd"
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
