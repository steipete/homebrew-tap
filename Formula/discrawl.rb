class Discrawl < Formula
  desc "Discord archive CLI for local SQLite search and analysis"
  homepage "https://github.com/steipete/discrawl"
  version "0.1.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/steipete/discrawl/releases/download/v#{version}/discrawl_#{version}_darwin_arm64.tar.gz"
      sha256 "3f304f878c8a7934fc65d8bc8d8afa7e2b489ed00a38a27f170c45a30368eddc"
    else
      url "https://github.com/steipete/discrawl/releases/download/v#{version}/discrawl_#{version}_darwin_amd64.tar.gz"
      sha256 "a7e1281da564d647cba42360a07a256dcc484ec78a605cfcd9c0084cd9835066"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/steipete/discrawl/releases/download/v#{version}/discrawl_#{version}_linux_arm64.tar.gz"
      sha256 "830aa1eebb904083a1cabd7c077bfdc9cf13fa938d719e1ad1359809e48efe4c"
    else
      url "https://github.com/steipete/discrawl/releases/download/v#{version}/discrawl_#{version}_linux_amd64.tar.gz"
      sha256 "530acda186eeda3aa54331b6a0292d78c12d267d89fd489299052c3871135a4d"
    end
  end

  def install
    bin.install "discrawl"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/discrawl --version")
  end
end
