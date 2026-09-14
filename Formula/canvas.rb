class Canvas < Formula
  desc "Visual workspace for agents"
  homepage "https://github.com/steipete/canvas"
  version "0.1.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/steipete/canvas/releases/download/v#{version}/canvas_#{version}_darwin_arm64.tar.gz"
      sha256 "2964787ec5dd3bcf0e2c4497ed3e0e01e46b1300dd250a153755e8e18f1c9b2e"
    else
      url "https://github.com/steipete/canvas/releases/download/v#{version}/canvas_#{version}_darwin_amd64.tar.gz"
      sha256 "6aeecfa7a7717de254e98952120a6a2f5802297d76f4662bfd52572fc254af53"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/steipete/canvas/releases/download/v#{version}/canvas_#{version}_linux_arm64.tar.gz"
      sha256 "44d00e730aadd3814c6d945988cac0832ab2a079474cef04f0956460521b5dec"
    else
      url "https://github.com/steipete/canvas/releases/download/v#{version}/canvas_#{version}_linux_amd64.tar.gz"
      sha256 "48615dc3a637765af64f9651f769cf41e3270b2ad36e6ab15c01397966ddfce1"
    end
  end

  def install
    bin.install "canvas"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/canvas --version")
  end
end
