class Codexbar < Formula
  desc "Menu bar usage and status CLI"
  homepage "https://github.com/steipete/CodexBar"
  url "https://github.com/steipete/CodexBar/releases/download/v0.24/CodexBarCLI-v0.24-macos-arm64.tar.gz"
  version "0.24"
  sha256 "c165978b0cd81d525e726ee3964ed65903cf736d22eeaa492c9a792f859d7091"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/steipete/CodexBar/releases/download/v#{version}/CodexBarCLI-v#{version}-macos-arm64.tar.gz"
      sha256 "c165978b0cd81d525e726ee3964ed65903cf736d22eeaa492c9a792f859d7091"
    else
      url "https://github.com/steipete/CodexBar/releases/download/v#{version}/CodexBarCLI-v#{version}-macos-x86_64.tar.gz"
      sha256 "22abf4e3adffe51e5e126d0a17119e111bc18dabb51621214fb7ae32d1a201d0"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/steipete/CodexBar/releases/download/v#{version}/CodexBarCLI-v#{version}-linux-aarch64.tar.gz"
      sha256 "c633932deb413622f569a7f0b071a9a6374b1df551b59d7117afddee2e08bcb6"
    else
      url "https://github.com/steipete/CodexBar/releases/download/v#{version}/CodexBarCLI-v#{version}-linux-x86_64.tar.gz"
      sha256 "4939168b3d76fd5ee568fb64fda5b2104e7a9623b61e35e1d51dadc471f16b81"
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
