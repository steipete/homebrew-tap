class Goplaces < Formula
  desc "Modern Go client + CLI for the Google Places API (New)"
  homepage "https://github.com/steipete/goplaces"
  version "0.3.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/steipete/goplaces/releases/download/v#{version}/goplaces_#{version}_darwin_arm64.tar.gz"
      sha256 "14084bccdec26cc8215cd4cb3cec9a44726332e52df8b943a16455d33412a665"
    else
      url "https://github.com/steipete/goplaces/releases/download/v#{version}/goplaces_#{version}_darwin_amd64.tar.gz"
      sha256 "46e7bae887a75fd317ebd9c0c03183312379fb62f3cde67c9c4ecdd9e0af4751"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/steipete/goplaces/releases/download/v#{version}/goplaces_#{version}_linux_arm64.tar.gz"
      sha256 "221c00ff137b4aa76835ded607e46d38a1ec986ca8fbad886430440d67debd1b"
    else
      url "https://github.com/steipete/goplaces/releases/download/v#{version}/goplaces_#{version}_linux_amd64.tar.gz"
      sha256 "cfa78d4d9a362bbc2c3d3ff7777160fb5a5994de7e8521b00481b72d4053b1e7"
    end
  end

  def install
    bin.install "goplaces"
  end

  test do
    system "#{bin}/goplaces", "--version"
  end
end
