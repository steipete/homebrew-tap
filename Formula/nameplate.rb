class Nameplate < Formula
  desc "Brand Linux machines with click-through identity overlays"
  homepage "https://github.com/steipete/Nameplate"
  url "https://github.com/steipete/Nameplate/archive/refs/tags/v0.3.0.tar.gz"
  sha256 "4b84013712e4ba84f579a41b90f4ea98b3df2be2d9ff413ac143455ec7ef6177"
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
