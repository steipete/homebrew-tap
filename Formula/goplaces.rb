class Goplaces < Formula
  desc "Modern Go client + CLI for the Google Places API (New)"
  homepage "https://github.com/steipete/goplaces"
  version "0.4.1"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/steipete/goplaces/releases/download/v0.4.1/goplaces_#{version}_darwin_arm64.tar.gz"
      sha256 "a0a8a476d5acf431e4d1afa943c3005ee28ff75335e9ee974926af0fbd9f69f2"
    else
      url "https://github.com/steipete/goplaces/releases/download/v0.4.1/goplaces_#{version}_darwin_amd64.tar.gz"
      sha256 "83bb8cda184d75609348f64dd66a903a09173edaeb8cd4dada273b439af2a71c"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/steipete/goplaces/releases/download/v0.4.1/goplaces_#{version}_linux_arm64.tar.gz"
      sha256 "e6620b495e70a5e7b1ae7193fcd32f570008cfff0dc47f9f3acfe3c379bd5dc0"
    else
      url "https://github.com/steipete/goplaces/releases/download/v0.4.1/goplaces_#{version}_linux_amd64.tar.gz"
      sha256 "b5830bd39951594d35df212c57d45686b98b72d72e08d5988ee08012c3f26a51"
    end
  end

  def install
    bin.install "goplaces"
  end

  test do
    system "#{bin}/goplaces", "--version"
  end
end
