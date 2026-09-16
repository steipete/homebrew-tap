class Codexbar < Formula
  desc "Menu bar usage and status CLI"
  homepage "https://github.com/steipete/CodexBar"
  version "0.60.4"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/steipete/CodexBar/releases/download/v#{version}/CodexBarCLI-v#{version}-macos-arm64.tar.gz"
      sha256 "69a1b527027850dda1345734954cb900790106333d2f956d025549331345a4a7"
    else
      url "https://github.com/steipete/CodexBar/releases/download/v#{version}/CodexBarCLI-v#{version}-macos-x86_64.tar.gz"
      sha256 "b33cdb0ce1b94dbd4ed85a08dc0c2cceec57673c34401daa6a8a1f6b9af091da"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/steipete/CodexBar/releases/download/v#{version}/CodexBarCLI-v#{version}-linux-aarch64.tar.gz"
      sha256 "9f62aa1f331a02bfe146d387a476316db266140e68b7cbc5504374d61c06f3dc"
    else
      url "https://github.com/steipete/CodexBar/releases/download/v#{version}/CodexBarCLI-v#{version}-linux-x86_64.tar.gz"
      sha256 "12b51e3016500a7068b73f45c50a034d0e436d6599430c83c1ee3112592005e3"
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
