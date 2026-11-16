class Canvas < Formula
  desc "Visual workspace for agents"
  homepage "https://github.com/steipete/canvas"
  version "0.2.1"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/steipete/canvas/releases/download/v#{version}/canvas_#{version}_darwin_arm64.tar.gz"
      sha256 "4d2d21c664cda0e1898bf61bcf53ee9c68609ae3f3d6d854ac5875cb00c5a0fd"
    else
      url "https://github.com/steipete/canvas/releases/download/v#{version}/canvas_#{version}_darwin_amd64.tar.gz"
      sha256 "a910085fed97a1a69aae8555b568403b0b105a9ce528092b3a29e7ac2ee3527e"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/steipete/canvas/releases/download/v#{version}/canvas_#{version}_linux_arm64.tar.gz"
      sha256 "ad607b26b24c30d66f5dc4f06543e04ce76f01ae73ca0f825496d6532c4e746e"
    else
      url "https://github.com/steipete/canvas/releases/download/v#{version}/canvas_#{version}_linux_amd64.tar.gz"
      sha256 "edd691c2ea9e20bf2f4f695f188bdb976949a85d8a878239a1e5d052a676411c"
    end
  end

  def install
    bin.install "canvas"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/canvas --version")
  end
end
