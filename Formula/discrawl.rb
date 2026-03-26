class Discrawl < Formula
  desc "Discord archive CLI for local SQLite search and analysis"
  homepage "https://github.com/steipete/discrawl"
  version "0.2.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/steipete/discrawl/releases/download/v#{version}/discrawl_#{version}_darwin_arm64.tar.gz"
      sha256 "09a2d6a7cbd824b2850dbf20e1d59204b484ef1cc3adad166a286f57d0f5e63c"
    else
      url "https://github.com/steipete/discrawl/releases/download/v#{version}/discrawl_#{version}_darwin_amd64.tar.gz"
      sha256 "39970e9a8b99c2699533c008ba155ed3122534b94df32fefc9bab54a8c663ebc"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/steipete/discrawl/releases/download/v#{version}/discrawl_#{version}_linux_arm64.tar.gz"
      sha256 "76092af669943d82bfbb635a395605ba0a92f57c866fc35c3c0833bc33298418"
    else
      url "https://github.com/steipete/discrawl/releases/download/v#{version}/discrawl_#{version}_linux_amd64.tar.gz"
      sha256 "57eba0c982b862981c8309161c625a211b4563a5d6a72eaeec5116b540e09c19"
    end
  end

  def install
    bin.install "discrawl"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/discrawl --version")
  end
end
