class Nameplate < Formula
  desc "Brand Linux machines with click-through identity overlays"
  homepage "https://github.com/steipete/Nameplate"
  url "https://github.com/steipete/Nameplate/archive/refs/tags/v0.5.1.tar.gz"
  sha256 "d5261a2d889b94a4b8840c1ab5a8b3b5d0728b713e0cbafeb89393f2a1ecb714"
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
