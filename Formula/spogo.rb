class Spogo < Formula
  desc "Spotify power CLI using web cookies"
  homepage "https://github.com/openclaw/spogo"
  version "0.13.2"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/openclaw/spogo/releases/download/v0.13.2/spogo_0.13.2_darwin_arm64.tar.gz"
      sha256 "a230b339eed2e17ad79f79a3672982ab0ac43e8659cf716778e31495fbf97b61"
    else
      url "https://github.com/openclaw/spogo/releases/download/v0.13.2/spogo_0.13.2_darwin_amd64.tar.gz"
      sha256 "367d45bec4f411a8c6f1fd0ba4fde5bd5d21cc10e314a3e22621b307f987f5c2"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/openclaw/spogo/releases/download/v0.13.2/spogo_0.13.2_linux_arm64.tar.gz"
      sha256 "1b5a3d95545774fe316236925502f3917e7280d10d1181cac018bbb07f2f6c2c"
    else
      url "https://github.com/openclaw/spogo/releases/download/v0.13.2/spogo_0.13.2_linux_amd64.tar.gz"
      sha256 "7e0a0a656441b9ef60871ba19479f865074e682b820075e68002e7af5457eaf1"
    end
  end

  def install
    bin.install "spogo"
  end

  test do
    assert_match "spogo", shell_output("#{bin}/spogo --help")
  end
end
