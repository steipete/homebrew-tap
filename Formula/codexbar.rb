class Codexbar < Formula
  desc "Menu bar usage and status CLI"
  homepage "https://github.com/steipete/CodexBar"
  version "0.57.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/steipete/CodexBar/releases/download/v#{version}/CodexBarCLI-v#{version}-macos-arm64.tar.gz"
      sha256 "5a85b3a36eb8bc2b0d4433a40df7d71d21d34db7d4c2b498bcaec0642f2307cc"
    else
      url "https://github.com/steipete/CodexBar/releases/download/v#{version}/CodexBarCLI-v#{version}-macos-x86_64.tar.gz"
      sha256 "9be8dba2304f923ae7a8b6ecbbe734171351e1aa3fa6b66e9ed629aed1da15eb"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/steipete/CodexBar/releases/download/v#{version}/CodexBarCLI-v#{version}-linux-aarch64.tar.gz"
      sha256 "5661340ae6429b22c20819d1888f1637741a9fd2e2b00999d67e6518b19e26e8"
    else
      url "https://github.com/steipete/CodexBar/releases/download/v#{version}/CodexBarCLI-v#{version}-linux-x86_64.tar.gz"
      sha256 "bde7f64464d608f6ff7c1544f83171ed49420a64652f20a2341576d689818b52"
    end
  end

  def install
    libexec.install "CodexBarCLI"
    libexec.install "VERSION"
    # JS provider plugins (zai, openai, xai, ...) load from this bundle next to the executable.
    libexec.install "CodexBar_CodexBarCore.bundle" if File.exist?("CodexBar_CodexBarCore.bundle")
    bin.write_exec_script libexec/"CodexBarCLI"
    bin.install_symlink "CodexBarCLI" => "codexbar"
  end

  test do
    assert_equal "CodexBar #{version}", shell_output("#{bin}/codexbar --version").strip
  end
end
