class Codexbar < Formula
  desc "Menu bar usage and status CLI"
  homepage "https://github.com/steipete/CodexBar"
  version "0.70.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/steipete/CodexBar/releases/download/v#{version}/CodexBarCLI-v#{version}-macos-arm64.tar.gz"
      sha256 "229fcd3fa7255fc3b8d90bbd209d6db41d563ce20b36e56d9b6b1b01ad670496"
    else
      url "https://github.com/steipete/CodexBar/releases/download/v#{version}/CodexBarCLI-v#{version}-macos-x86_64.tar.gz"
      sha256 "151f4a39403b1193a5e25bf758d3e3793659db4f2de25db2407557f9ebc3c06b"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/steipete/CodexBar/releases/download/v#{version}/CodexBarCLI-v#{version}-linux-aarch64.tar.gz"
      sha256 "74b4f360630ac15d2ea79509ca4fcaff205f32c40a88baff900e2e29a7f26f90"
    else
      url "https://github.com/steipete/CodexBar/releases/download/v#{version}/CodexBarCLI-v#{version}-linux-x86_64.tar.gz"
      sha256 "e3f6be18fe7068db2dfcfa93c5b3bee209a28d7a71a52455ef9f383a3d2c459c"
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
