require "language/node"

class Mcporter < Formula
  desc "Model Context Protocol runtime and CLI generator"
  homepage "https://github.com/openclaw/mcporter"
  url "https://github.com/openclaw/mcporter/releases/download/v0.11.2/mcporter-0.11.2.tgz"
  sha256 "379e1010daa4df47f8c1df068e749bc2b3c7d7d36905abaf1923ba342c0eadcb"
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
