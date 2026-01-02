class Tmuxwatch < Formula
  desc "Live tmux dashboard with Bubble Tea UI"
  homepage "https://github.com/steipete/tmuxwatch"
  version "0.9.2"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/steipete/tmuxwatch/releases/download/v#{version}/tmuxwatch_#{version}_darwin_arm64.tar.gz"
      sha256 "5ce42b6b46c2890422c23b41d75af4a9675d21a81c47dacda708e41e78effb9e"
    else
      url "https://github.com/steipete/tmuxwatch/releases/download/v#{version}/tmuxwatch_#{version}_darwin_amd64.tar.gz"
      sha256 "110c9427705bbb4ff05974eda78e1fe12b7caf9a2ffe977e14d08ddb90ba2f0f"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/steipete/tmuxwatch/releases/download/v#{version}/tmuxwatch_#{version}_linux_arm64.tar.gz"
      sha256 "34721d7754edc33e041ab82cb443f2becd1e8c14ca001c8a537a2c0775433d68"
    else
      url "https://github.com/steipete/tmuxwatch/releases/download/v#{version}/tmuxwatch_#{version}_linux_amd64.tar.gz"
      sha256 "e66b817efa4255ca0d03b5ddbeda9f3291ac99f298799a4464a17bc14d114b98"
    end
  end

  def install
    bin.install "tmuxwatch"
  end

  test do
    assert_match "tmuxwatch 0.9.2", shell_output("#{bin}/tmuxwatch --version")
  end
end
