class Codexbar < Formula
  desc "Menu bar usage and status CLI"
  homepage "https://github.com/steipete/CodexBar"
  url "https://github.com/steipete/CodexBar/releases/download/v0.24/CodexBarCLI-v0.24-macos-arm64.tar.gz"
  version "0.25"
  sha256 "c165978b0cd81d525e726ee3964ed65903cf736d22eeaa492c9a792f859d7091"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/steipete/CodexBar/releases/download/v#{version}/CodexBarCLI-v#{version}-macos-arm64.tar.gz"
      sha256 "3cc76aff329c59a84498147dd16ab4b7372875f2e0c8aa6586ca9c5dafaf6c7b"
    else
      url "https://github.com/steipete/CodexBar/releases/download/v#{version}/CodexBarCLI-v#{version}-macos-x86_64.tar.gz"
      sha256 "784dd3b082388f837d2fb77cb98b9d11a415ce2715b66f4ceee18c57c942ed33"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/steipete/CodexBar/releases/download/v#{version}/CodexBarCLI-v#{version}-linux-aarch64.tar.gz"
      sha256 "b770e9037204bfbc94def49dac6ac675a5dbec9b196c470e85367593a7e7c510"
    else
      url "https://github.com/steipete/CodexBar/releases/download/v#{version}/CodexBarCLI-v#{version}-linux-x86_64.tar.gz"
      sha256 "2450a11b22abae1dbd8fb7f7884e5a68a86c7073cdf12a320d85c07eac772609"
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
