class Gifgrep < Formula
  desc "Grep the GIF. Stick the landing"
  homepage "https://github.com/steipete/gifgrep"
  version "0.3.1"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/steipete/gifgrep/releases/download/v#{version}/gifgrep_#{version}_darwin_arm64.tar.gz"
      sha256 "ad41051f5e8476ba96fc91bd601748d0c677cf9f4b98cfb61ccc0acb5948d628"
    else
      url "https://github.com/steipete/gifgrep/releases/download/v#{version}/gifgrep_#{version}_darwin_amd64.tar.gz"
      sha256 "77fef3d4c83205c1bb5cbdd3f7326484fe2df2ac30cb6bb791252a289312db14"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/steipete/gifgrep/releases/download/v#{version}/gifgrep_#{version}_linux_arm64.tar.gz"
      sha256 "ce71cd8b7467f521533c5d259b168fdb2c8de1403dc8992dfafaee3129dd0afc"
    else
      url "https://github.com/steipete/gifgrep/releases/download/v#{version}/gifgrep_#{version}_linux_amd64.tar.gz"
      sha256 "8a5b55412c8fb2f51f6d55de683b77b449c5fda7310f4ab73e48ce7067e775b5"
    end
  end

  def install
    bin.install "gifgrep"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/gifgrep --version")
  end
end
