class Canvas < Formula
  desc "Visual workspace for agents"
  homepage "https://github.com/steipete/canvas"
  version "0.2.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/steipete/canvas/releases/download/v#{version}/canvas_#{version}_darwin_arm64.tar.gz"
      sha256 "d6dd56b523f872813522f1fa81499c2afd41313b11cfb26602331cc7a1ed161a"
    else
      url "https://github.com/steipete/canvas/releases/download/v#{version}/canvas_#{version}_darwin_amd64.tar.gz"
      sha256 "abfa28d4db2b8cb77193ce4faa5ef55a219fdaf5ecc824477f135e8865e36318"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/steipete/canvas/releases/download/v#{version}/canvas_#{version}_linux_arm64.tar.gz"
      sha256 "6352fec9027c5140a079df917a4c722d4f663a1d18cea8a02ff78fdb7ace9ec3"
    else
      url "https://github.com/steipete/canvas/releases/download/v#{version}/canvas_#{version}_linux_amd64.tar.gz"
      sha256 "d32bd31409981cc438a1fe0c567eff1df5931c5dd5ce1c80f5529988c9a5dfc5"
    end
  end

  def install
    bin.install "canvas"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/canvas --version")
  end
end
