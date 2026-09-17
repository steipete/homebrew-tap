class Codexbar < Formula
  desc "Menu bar usage and status CLI"
  homepage "https://github.com/steipete/CodexBar"
  version "0.60.5"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/steipete/CodexBar/releases/download/v#{version}/CodexBarCLI-v#{version}-macos-arm64.tar.gz"
      sha256 "ed6f7acb99a1d9f971e10b722782143b7b9d22794d8010280600e5c9f5a3233d"
    else
      url "https://github.com/steipete/CodexBar/releases/download/v#{version}/CodexBarCLI-v#{version}-macos-x86_64.tar.gz"
      sha256 "a390937b2bb5697f8db65c238577f08a0a7a502aa10297bbab9283f8a7dc1953"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/steipete/CodexBar/releases/download/v#{version}/CodexBarCLI-v#{version}-linux-aarch64.tar.gz"
      sha256 "194dedbb0704f223c715e6fb7e4a7284a47cc5e49485d7df0676913cae3f7594"
    else
      url "https://github.com/steipete/CodexBar/releases/download/v#{version}/CodexBarCLI-v#{version}-linux-x86_64.tar.gz"
      sha256 "2700156a941547cc75d79cfdffd35bec5c0332ea49c5a1c301479abc662c43d8"
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
