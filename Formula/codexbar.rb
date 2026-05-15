class Codexbar < Formula
  desc "Menu bar usage and status CLI"
  homepage "https://github.com/steipete/CodexBar"
  url "https://github.com/steipete/CodexBar/releases/download/v0.26.0/CodexBarCLI-v0.26.0-macos-arm64.tar.gz"
  version "0.26.0"
  sha256 "228022e18078f5351ef78f752c91fca8633e356b80546d23d49ed87239cb83b7"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/steipete/CodexBar/releases/download/v#{version}/CodexBarCLI-v#{version}-macos-arm64.tar.gz"
      sha256 "228022e18078f5351ef78f752c91fca8633e356b80546d23d49ed87239cb83b7"
    else
      url "https://github.com/steipete/CodexBar/releases/download/v#{version}/CodexBarCLI-v#{version}-macos-x86_64.tar.gz"
      sha256 "63f9423a69c2ea7e1ae250ee145836bae23be8e0610914403191886061708b11"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/steipete/CodexBar/releases/download/v#{version}/CodexBarCLI-v#{version}-linux-aarch64.tar.gz"
      sha256 "926028e37837643538a7250da752c36c6cbd7c791b2d6b472a3dbc99e8f71638"
    else
      url "https://github.com/steipete/CodexBar/releases/download/v#{version}/CodexBarCLI-v#{version}-linux-x86_64.tar.gz"
      sha256 "983c95ebbaa373dfbb1859dd974c66fc4f67ea3ab64885ca118bef9ce88007af"
    end
  end

  def install
    bin.install "CodexBarCLI"
    bin.install "VERSION"
    bin.install_symlink "CodexBarCLI" => "codexbar"
  end

  test do
    assert_equal "CodexBar #{version}", shell_output("#{bin}/codexbar --version").strip
  end
end
