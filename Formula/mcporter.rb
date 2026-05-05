require "language/node"

class Mcporter < Formula
  desc "Model Context Protocol runtime and CLI generator"
  homepage "https://github.com/steipete/mcporter"
  url "https://github.com/steipete/mcporter/releases/download/v0.10.1/mcporter-0.10.1.tgz"
  sha256 "efef969838b18df0bcbc3b5fe3d4a7057a96e99c46a3f25e2deb0dfd7afee1d3"
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
