class Eightctl < Formula
  desc "Control Eight Sleep Pods from the terminal"
  homepage "https://github.com/steipete/eightctl"
  version "0.2.7"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/steipete/eightctl/releases/download/v0.2.7/eightctl_0.2.7_darwin_arm64.tar.gz"
      sha256 "3635d6845d3eaab1c0f64440ffe98f44644d388177d2843dd1979dbec87e08db"
    else
      url "https://github.com/steipete/eightctl/releases/download/v0.2.7/eightctl_0.2.7_darwin_amd64.tar.gz"
      sha256 "44f2e48eee28bda688393483fd6c508062cd84843cad54035166f4c5f9ac3897"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/steipete/eightctl/releases/download/v0.2.7/eightctl_0.2.7_linux_arm64.tar.gz"
      sha256 "7105f6044f5236a86f8f98575a43e1d43e158a29c238e2b8348363ca4dcaf590"
    else
      url "https://github.com/steipete/eightctl/releases/download/v0.2.7/eightctl_0.2.7_linux_amd64.tar.gz"
      sha256 "9b92a1f8ef9f8b1b9042b31a8a5fde1d311a82af0c96f655f5a7f45ca4011874"
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
