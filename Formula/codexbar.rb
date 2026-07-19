class Codexbar < Formula
  desc "Menu bar usage and status CLI"
  homepage "https://github.com/steipete/CodexBar"
  version "0.45.2"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/steipete/CodexBar/releases/download/v#{version}/CodexBarCLI-v#{version}-macos-arm64.tar.gz"
      sha256 "df83f412016bbb70c3011ae2c38e36fc211c39cae7e4dc7c655b6c968622e7bc"
    else
      url "https://github.com/steipete/CodexBar/releases/download/v#{version}/CodexBarCLI-v#{version}-macos-x86_64.tar.gz"
      sha256 "fb433b69f91b1459a6be2f1c630814eb71f84e9e63ed28bce0e56a3bea6feb5a"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/steipete/CodexBar/releases/download/v#{version}/CodexBarCLI-v#{version}-linux-aarch64.tar.gz"
      sha256 "d5635c9e5b7524ecd4aa91d0de30a3c18f3c9d1fcaa3920187a6d6c7f3b8bbc0"
    else
      url "https://github.com/steipete/CodexBar/releases/download/v#{version}/CodexBarCLI-v#{version}-linux-x86_64.tar.gz"
      sha256 "f5ca9e5bbe511493902bd8fd7d2c409c9b4800259967284a05a73627156a5f2e"
    end
  end

  def install
    libexec.install "CodexBarCLI"
    libexec.install "VERSION"
    bin.write_exec_script libexec/"CodexBarCLI"
    bin.install_symlink "CodexBarCLI" => "codexbar"
  end

  test do
    assert_equal "CodexBar #{version}", shell_output("#{bin}/codexbar --version").strip
  end
end
