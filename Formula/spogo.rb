class Spogo < Formula
  desc "Spotify power CLI using web cookies"
  homepage "https://github.com/openclaw/spogo"
  version "0.10.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/openclaw/spogo/releases/download/v0.10.0/spogo_0.10.0_darwin_arm64.tar.gz"
      sha256 "9184755942eec207ea86e5d85ee59c27866491235991dd4b6c054ed3f9bde136"
    else
      url "https://github.com/openclaw/spogo/releases/download/v0.10.0/spogo_0.10.0_darwin_amd64.tar.gz"
      sha256 "fdb7c6a05c5320eba1aea180cc8e8ec4a877dda9f265b6376bc3b8e776692c9f"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/openclaw/spogo/releases/download/v0.10.0/spogo_0.10.0_linux_arm64.tar.gz"
      sha256 "3fa52597cb362569f72dba39822b5ad8d9aa7caeaa612f959f1c2e7e4b8cab9a"
    else
      url "https://github.com/openclaw/spogo/releases/download/v0.10.0/spogo_0.10.0_linux_amd64.tar.gz"
      sha256 "89221da844c9818d0db95d756e1ae7a14e145ce420a9ac37166977b9250df096"
    end
  end

  def install
    bin.install "spogo"
  end

  test do
    assert_match "spogo", shell_output("#{bin}/spogo --help")
  end
end
