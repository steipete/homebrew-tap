class Nameplate < Formula
  desc "Brand Linux machines with click-through identity overlays"
  homepage "https://github.com/steipete/Nameplate"
  url "https://github.com/steipete/Nameplate/archive/refs/tags/v0.4.0.tar.gz"
  sha256 "9b5f66d8bb5d88c275420f21602f9e9460d1cee84163d5cba3375e11bae23cdf"
  license "MIT"

  depends_on "pkgconf" => :build
  depends_on "rust" => :build
  depends_on "gtk4"
  depends_on "libx11"
  depends_on :linux

  def install
    system "cargo", "install", *std_cargo_args(path: "linux/nameplate")
  end

  test do
    assert_match "Nameplate for Linux", shell_output("#{bin}/nameplate --help")
    invalid = shell_output("#{bin}/nameplate unsupported 2>&1", 2)
    assert_match "unknown command", invalid
    assert_match "Usage:", invalid
  end
end
