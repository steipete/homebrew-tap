class Gogcli < Formula
  desc "Google CLI for Gmail, Calendar, Drive, and Contacts"
  homepage "https://github.com/steipete/gogcli"
  version "0.8.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/steipete/gogcli/releases/download/v#{version}/gogcli_#{version}_darwin_arm64.tar.gz"
      sha256 "8a32c0568237e2ab9a28bc56e4107141bb00a2932f0a681888ed5810c7de6e9e"
    else
      url "https://github.com/steipete/gogcli/releases/download/v#{version}/gogcli_#{version}_darwin_amd64.tar.gz"
      sha256 "9f0779848a7ba23955960c24978d9b4afcf3f508d644c99d9fddb657dec1ddf6"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/steipete/gogcli/releases/download/v#{version}/gogcli_#{version}_linux_arm64.tar.gz"
      sha256 "a3244840fad6fa842f1497afaeaadbfc6c3a9e8f4bdc17273894fb29253bb3e9"
    else
      url "https://github.com/steipete/gogcli/releases/download/v#{version}/gogcli_#{version}_linux_amd64.tar.gz"
      sha256 "77ba38ce89ae5f0ce57fd9d02590392a45dfa2e942189bd62796fee75c30f61a"
    end
  end

  def install
    bin.install "gog"
  end

  test do
    assert_match "Google CLI", shell_output("#{bin}/gog --help")
  end
end
