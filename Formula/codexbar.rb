class Codexbar < Formula
  desc "Menu bar usage and status CLI"
  homepage "https://github.com/steipete/CodexBar"
  url "https://github.com/steipete/CodexBar/releases/download/v0.23/CodexBarCLI-v0.23-linux-x86_64.tar.gz"
  version "0.23"
  sha256 "710c2697672516d7bec15e51b93a6a7bfb8de3056bc0690ad69d5ba6a6ece4e9"
  license "MIT"

  depends_on :linux

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/steipete/CodexBar/releases/download/v#{version}/CodexBarCLI-v#{version}-linux-aarch64.tar.gz"
      sha256 "f79e00b911bfb6d0f629c40b4d81c930d590152883d6b7ee415fb9c7060b4770"
    else
      url "https://github.com/steipete/CodexBar/releases/download/v#{version}/CodexBarCLI-v#{version}-linux-x86_64.tar.gz"
      sha256 "710c2697672516d7bec15e51b93a6a7bfb8de3056bc0690ad69d5ba6a6ece4e9"
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
