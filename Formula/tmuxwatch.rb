class Tmuxwatch < Formula
  desc "Live tmux dashboard with Bubble Tea UI"
  homepage "https://github.com/steipete/tmuxwatch"
  version "0.9.3"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/steipete/tmuxwatch/releases/download/v#{version}/tmuxwatch_#{version}_darwin_arm64.tar.gz"
      sha256 "6d3b2679509b9bbde06929e8a87e04c53c85b9f97e3766ce6712156d1195455f"
    else
      url "https://github.com/steipete/tmuxwatch/releases/download/v#{version}/tmuxwatch_#{version}_darwin_amd64.tar.gz"
      sha256 "9eec262c96aabc70797dd3615340d4426c83cd3813221f1ca6e20abefce24f1c"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/steipete/tmuxwatch/releases/download/v#{version}/tmuxwatch_#{version}_linux_arm64.tar.gz"
      sha256 "3ffa14362ab45599e1f09d3a93aee65d714651f291cc3669e0922ff200f822ea"
    else
      url "https://github.com/steipete/tmuxwatch/releases/download/v#{version}/tmuxwatch_#{version}_linux_amd64.tar.gz"
      sha256 "dbdf114e88035c85953a618628d1fa948f537234f9b7ceecaf01951f748b52b2"
    end
  end

  def install
    bin.install "tmuxwatch"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/tmuxwatch --version")
  end
end
