class Octopool < Formula
  desc "Org-gated GitHub read relay and cache CLI"
  homepage "https://github.com/openclaw/octopool"
  version "0.2.1"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/openclaw/octopool/releases/download/v#{version}/octopool_#{version}_darwin_arm64.tar.gz"
      sha256 "1b97d9a5144c2d17ece4999dce8295ea40e053fea3102b895d8619efd4f4f7f4"
    else
      url "https://github.com/openclaw/octopool/releases/download/v#{version}/octopool_#{version}_darwin_amd64.tar.gz"
      sha256 "088593a640cf2a9cef45d9647bb58db9747b8b0401e69f189b8f22aec0aa997d"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/openclaw/octopool/releases/download/v#{version}/octopool_#{version}_linux_arm64.tar.gz"
      sha256 "57235e7c6e1590a4580255d27f45f6fa85897fe1ca532cf97b9a92b0cfde36da"
    else
      url "https://github.com/openclaw/octopool/releases/download/v#{version}/octopool_#{version}_linux_amd64.tar.gz"
      sha256 "64142def88b76d36b0b9579f3ad692a190f431442b632fc21316378e84541412"
    end
  end

  def install
    bin.install "octopool"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/octopool --version")
  end
end
