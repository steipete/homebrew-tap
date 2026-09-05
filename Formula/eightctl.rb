class Eightctl < Formula
  desc "Control Eight Sleep Pods from the terminal"
  homepage "https://github.com/steipete/eightctl"
  version "0.2.4"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/steipete/eightctl/releases/download/v0.2.4/eightctl_0.2.4_darwin_arm64.tar.gz"
      sha256 "f87d9ec56ecbfd9633a802f2668e71cf7abf2b641cd4cc9b2dfd2f569981964a"
    else
      url "https://github.com/steipete/eightctl/releases/download/v0.2.4/eightctl_0.2.4_darwin_amd64.tar.gz"
      sha256 "0c377568857571691e09d632b857de12bc9fe48e7f1a31627f3346995446ff16"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/steipete/eightctl/releases/download/v0.2.4/eightctl_0.2.4_linux_arm64.tar.gz"
      sha256 "119c6c20990bcadf88a9b0214c20f5b9634fa24431f1cf7ad479818699bad015"
    else
      url "https://github.com/steipete/eightctl/releases/download/v0.2.4/eightctl_0.2.4_linux_amd64.tar.gz"
      sha256 "0387427e44aa16a93d095247e7c1726f471457f3eef7f3294ed8415c5d178a5d"
    end
  end

  def install
    bin.install "eightctl"
  end

  test do
    assert_equal version.to_s, shell_output("#{bin}/eightctl version").strip
    assert_match "Control your Eight Sleep Pod", shell_output("#{bin}/eightctl --help")
    assert_match "Show device status", shell_output("#{bin}/eightctl status --help")
  end
end
