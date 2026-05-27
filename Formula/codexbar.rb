class Codexbar < Formula
  desc "Menu bar usage and status CLI"
  homepage "https://github.com/steipete/CodexBar"
  version "0.30.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/steipete/CodexBar/releases/download/v#{version}/CodexBarCLI-v#{version}-macos-arm64.tar.gz"
      sha256 "9b8390ef5353e591d9dcd84c702a55600a7bf8534aa446e45c6eafea85791179"
    else
      url "https://github.com/steipete/CodexBar/releases/download/v#{version}/CodexBarCLI-v#{version}-macos-x86_64.tar.gz"
      sha256 "6039e4a7d6b0f911f508b6e1b6084061c52c3a251acef874b252bb04cd4ab82a"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/steipete/CodexBar/releases/download/v#{version}/CodexBarCLI-v#{version}-linux-aarch64.tar.gz"
      sha256 "78cfe45b5cd77a985362f749d1995742518cee706efc1931218f02c583f13681"
    else
      url "https://github.com/steipete/CodexBar/releases/download/v#{version}/CodexBarCLI-v#{version}-linux-x86_64.tar.gz"
      sha256 "cb638ba68fd7ef2e4b43b4899fd66720a330b9458346fb66207e9b5813b6e6f3"
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
