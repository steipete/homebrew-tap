class Codexbar < Formula
  desc "Menu bar usage and status CLI"
  homepage "https://github.com/steipete/CodexBar"
  url "https://github.com/steipete/CodexBar/releases/download/v0.24/CodexBarCLI-v0.24-macos-arm64.tar.gz"
  version "0.24"
  sha256 "f9a338cebfa8c23003528a86c03f06a22fdd3e836cf814dbf450f84cc1ab7eda"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/steipete/CodexBar/releases/download/v#{version}/CodexBarCLI-v#{version}-macos-arm64.tar.gz"
      sha256 "f9a338cebfa8c23003528a86c03f06a22fdd3e836cf814dbf450f84cc1ab7eda"
    else
      url "https://github.com/steipete/CodexBar/releases/download/v#{version}/CodexBarCLI-v#{version}-macos-x86_64.tar.gz"
      sha256 "aaec5831ede5c81110b59ae743d740b0bb830fc51afe0c16aea13df51c1ec4a6"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/steipete/CodexBar/releases/download/v#{version}/CodexBarCLI-v#{version}-linux-aarch64.tar.gz"
      sha256 "f8bc3706435056a0d549fd9ce52a8e4f265d4956d2b07e6e66e8aa0f8c9b63c6"
    else
      url "https://github.com/steipete/CodexBar/releases/download/v#{version}/CodexBarCLI-v#{version}-linux-x86_64.tar.gz"
      sha256 "d9ba937f4e9611389bb61ae21092242d5ef3329036a216d0c2ebe9ad5a979573"
    end
  end

  def install
    bin.install "CodexBarCLI"
    bin.install_symlink "CodexBarCLI" => "codexbar"
  end

  test do
    assert_match "CodexBar", shell_output("#{bin}/codexbar --version")
  end
end
