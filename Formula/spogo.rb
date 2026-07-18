class Spogo < Formula
  desc "Spotify power CLI using web cookies"
  homepage "https://github.com/openclaw/spogo"
  version "0.10.2"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/openclaw/spogo/releases/download/v0.10.2/spogo_0.10.2_spogo_darwin_darwin_arm64_v8.0.tar.gz"
      sha256 "0665b05720e76dfbea39e2a662d626a3e29d2d0df1b0caaaae50718147993990"
    else
      url "https://github.com/openclaw/spogo/releases/download/v0.10.2/spogo_0.10.2_spogo_darwin_darwin_amd64_v1.tar.gz"
      sha256 "c3947c5010cd397ce9c162ddcccc655ec617d67e7e6657496991f5c5747a711e"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/openclaw/spogo/releases/download/v0.10.2/spogo_0.10.2_spogo_linux_arm64_v8.0.tar.gz"
      sha256 "da15153de417131c89be6702f4936b9015a84296b4d68243b4e9f1b4588d516e"
    else
      url "https://github.com/openclaw/spogo/releases/download/v0.10.2/spogo_0.10.2_spogo_linux_amd64_v1.tar.gz"
      sha256 "573f8996bb1215eee0a8a63b7399b992d28fa44461f5b5f4a088597ad5fc0d84"
    end
  end

  def install
    bin.install "spogo"
  end

  test do
    assert_match "spogo", shell_output("#{bin}/spogo --help")
  end
end
