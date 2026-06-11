class Codexbar < Formula
  desc "Menu bar usage and status CLI"
  homepage "https://github.com/steipete/CodexBar"
  version "0.33.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/steipete/CodexBar/releases/download/v#{version}/CodexBarCLI-v#{version}-macos-arm64.tar.gz"
      sha256 "3886759fbd8f43fb12029f300ac32b232c5ab80c81759a1abeb33139c55d0723"
    else
      url "https://github.com/steipete/CodexBar/releases/download/v#{version}/CodexBarCLI-v#{version}-macos-x86_64.tar.gz"
      sha256 "95ea3b0c4dc1967070a9201e3443ac19c244702e673bf401670c0bc250980166"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/steipete/CodexBar/releases/download/v#{version}/CodexBarCLI-v#{version}-linux-aarch64.tar.gz"
      sha256 "c57dfb2632f82c27a543ebead3b26419b3dc42323158a2c8417ebb96de2d4d01"
    else
      url "https://github.com/steipete/CodexBar/releases/download/v#{version}/CodexBarCLI-v#{version}-linux-x86_64.tar.gz"
      sha256 "2dd59b021433fb614b15029d80ff3f4b1c0531c7b4baea4b911b004c0686a625"
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
