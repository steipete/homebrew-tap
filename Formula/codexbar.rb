class Codexbar < Formula
  desc "Menu bar usage and status CLI"
  homepage "https://github.com/steipete/CodexBar"
  version "0.50.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/steipete/CodexBar/releases/download/v#{version}/CodexBarCLI-v#{version}-macos-arm64.tar.gz"
      sha256 "8a4dc3d5cbc0c0fcc0154bb0d057e2bed943551c9fb990e972508db6c4851633"
    else
      url "https://github.com/steipete/CodexBar/releases/download/v#{version}/CodexBarCLI-v#{version}-macos-x86_64.tar.gz"
      sha256 "44a973556b4ef445ebda1be1f03ee4ef6a81d839eac1f08eeb536cdc587d9c26"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/steipete/CodexBar/releases/download/v#{version}/CodexBarCLI-v#{version}-linux-aarch64.tar.gz"
      sha256 "4dda9fc20490d0dfb6406c7a2fc27a0d93242e8fc5c80341f91f344e5d50f15b"
    else
      url "https://github.com/steipete/CodexBar/releases/download/v#{version}/CodexBarCLI-v#{version}-linux-x86_64.tar.gz"
      sha256 "8011ad514a66e787a9c4a00a43f06d2780db96571c047c5a2952b3137862a8a6"
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
