class Spogo < Formula
  desc "Spotify power CLI using web cookies"
  homepage "https://github.com/openclaw/spogo"
  version "0.10.4"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/openclaw/spogo/releases/download/v0.10.4/spogo_0.10.4_darwin_arm64.tar.gz"
      sha256 "59df33d68793d760a3ed1b69595f22b19e99be7b2bb073cdd14c333fc1d4b4e0"
    else
      url "https://github.com/openclaw/spogo/releases/download/v0.10.4/spogo_0.10.4_darwin_amd64.tar.gz"
      sha256 "5fa4e013441784df0092ab16a9c7ab3376090caad598bed06bdbefa636cf28cf"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/openclaw/spogo/releases/download/v0.10.4/spogo_0.10.4_linux_arm64.tar.gz"
      sha256 "853fa5f82acbc3519cede66c81bbb6fa31c2996c911c23fe7e2c80fadf20368b"
    else
      url "https://github.com/openclaw/spogo/releases/download/v0.10.4/spogo_0.10.4_linux_amd64.tar.gz"
      sha256 "dde403a72ad8c014b84add9dab8450f745f6393525418824c8f7527e895d67b0"
    end
  end

  def install
    bin.install "spogo"
  end

  test do
    assert_match "spogo", shell_output("#{bin}/spogo --help")
  end
end
