class Goplaces < Formula
  desc "Modern Go client + CLI for the Google Places API (New)"
  homepage "https://github.com/steipete/goplaces"
  version "0.4.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/steipete/goplaces/releases/download/v#{version}/goplaces_#{version}_darwin_arm64.tar.gz"
      sha256 "149f2156a421a7f3e9935ec2ac3264e1d9aeda9bd2db1057e5c03369fa5a33c8"
    else
      url "https://github.com/steipete/goplaces/releases/download/v#{version}/goplaces_#{version}_darwin_amd64.tar.gz"
      sha256 "fef54ad21aa1d6aded9624b2e26453f57de345ac9885601f64b4be56c15df8d5"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/steipete/goplaces/releases/download/v#{version}/goplaces_#{version}_linux_arm64.tar.gz"
      sha256 "62378b4432f0b906d43986589e9364b980efb26e783c1d639aa4c76acd93e556"
    else
      url "https://github.com/steipete/goplaces/releases/download/v#{version}/goplaces_#{version}_linux_amd64.tar.gz"
      sha256 "7141c3019e04a79d0ada58cb9fc2f225e58f26572bfeccad3fde54b0d992bf7c"
    end
  end

  def install
    bin.install "goplaces"
  end

  test do
    system "#{bin}/goplaces", "--version"
  end
end
