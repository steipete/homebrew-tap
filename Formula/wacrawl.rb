class Wacrawl < Formula
  desc "Read-only WhatsApp Desktop archive CLI"
  homepage "https://github.com/steipete/wacrawl"
  version "0.2.4"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/steipete/wacrawl/releases/download/v#{version}/wacrawl_#{version}_darwin_arm64.tar.gz"
      sha256 "be7e8637c8a7974e84c180915b4c650c931a8f78853fcd836ddb791e91ff34ca"
    else
      url "https://github.com/steipete/wacrawl/releases/download/v#{version}/wacrawl_#{version}_darwin_amd64.tar.gz"
      sha256 "5edf70deb39fadaaafe05af78c029b52eb6842931358b12e59df8354ff8e038d"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/steipete/wacrawl/releases/download/v#{version}/wacrawl_#{version}_linux_arm64.tar.gz"
      sha256 "934df7a116988c6754f4955d427df27e39b15b0fd4b523ec8d14e2b15182b1fb"
    else
      url "https://github.com/steipete/wacrawl/releases/download/v#{version}/wacrawl_#{version}_linux_amd64.tar.gz"
      sha256 "90ae04db8689c3822d2cade5c37b6c11b7dc15ef0e791eff88e2654c89cc4620"
    end
  end

  def install
    bin.install "wacrawl"
  end

  def caveats
    <<~EOS
      wacrawl reads WhatsApp Desktop data from:
        ~/Library/Group Containers/group.net.whatsapp.WhatsApp.shared

      It writes its archive to:
        ~/.wacrawl/wacrawl.db

      Quick start:
        wacrawl doctor
        wacrawl import
        wacrawl status
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/wacrawl --version")
  end
end
