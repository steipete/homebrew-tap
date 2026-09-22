class Gifgrep < Formula
  desc "Grep the GIF. Stick the landing"
  homepage "https://github.com/steipete/gifgrep"
  version "0.4.4"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/steipete/gifgrep/releases/download/v0.4.4/gifgrep_0.4.4_darwin_arm64.tar.gz"
      sha256 "167b6d8717b92aab88a9fb62349e8ffc440cc6232be7364564615914def61b32"
    else
      url "https://github.com/steipete/gifgrep/releases/download/v0.4.4/gifgrep_0.4.4_darwin_amd64.tar.gz"
      sha256 "111ca2e1dcee147b1521151488aba69f844c5b7a5f66a2d11d969f949905e8be"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/steipete/gifgrep/releases/download/v0.4.4/gifgrep_0.4.4_linux_arm64.tar.gz"
      sha256 "77a864f8d0903cf3f77c1e5afe6c31114d478ebe584d3b3e71f81fce21b0e86c"
    else
      url "https://github.com/steipete/gifgrep/releases/download/v0.4.4/gifgrep_0.4.4_linux_amd64.tar.gz"
      sha256 "974bb32c99f5b2931498809600a135e656f67e9cdfd5eff3fb018afbe8e886dc"
    end
  end

  def install
    bin.install "gifgrep"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/gifgrep --version")
  end
end
