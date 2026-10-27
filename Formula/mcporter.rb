require "language/node"

class Mcporter < Formula
  desc "Model Context Protocol runtime and CLI generator"
  homepage "https://github.com/openclaw/mcporter"
  url "https://github.com/openclaw/mcporter/releases/download/v0.16.1/mcporter-0.16.1.tgz"
  sha256 "b6c2d9a9c00a429f59c7cc721f15d2b34a08b62c2deab7910483ef996a1277da"
  license "MIT"

  depends_on "node"

  def install
    system "npm", "install", *std_npm_args, "--min-release-age=0"
    bin.install_symlink Dir["#{libexec}/bin/*"]
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/mcporter --version")
  end
end
