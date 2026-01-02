class Goplaces < Formula
  desc "Modern Go client + CLI for the Google Places API (New)"
  homepage "https://github.com/steipete/goplaces"
  version "0.1.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/steipete/goplaces/releases/download/v#{version}/goplaces_#{version}_darwin_arm64.tar.gz"
      sha256 "e94dac485e114f75bab3db664200eaf626a6bef563c4f70274f2c91b5cedf5e2"
    else
      url "https://github.com/steipete/goplaces/releases/download/v#{version}/goplaces_#{version}_darwin_amd64.tar.gz"
      sha256 "5405cc14b25914b1618434867d4795d4c37761a700d822711daba6b5960c4c79"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/steipete/goplaces/releases/download/v#{version}/goplaces_#{version}_linux_arm64.tar.gz"
      sha256 "b3b337af1ed00cf32e906f71611fb8f6e9b3b95a7c67be8af72c7a28980e7bdd"
    else
      url "https://github.com/steipete/goplaces/releases/download/v#{version}/goplaces_#{version}_linux_amd64.tar.gz"
      sha256 "d5b15fcaa0f366b1b5ee74476cb0b877200781f29869ff09e5618063f972a901"
    end
  end

  def install
    bin.install "goplaces"
  end

  test do
    system "#{bin}/goplaces", "--version"
  end
end
