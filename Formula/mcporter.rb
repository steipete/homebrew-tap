require "language/node"

class Mcporter < Formula
  desc "Model Context Protocol runtime and CLI generator"
  homepage "https://github.com/openclaw/mcporter"
  url "https://github.com/openclaw/mcporter/releases/download/v0.13.8/mcporter-0.13.8.tgz"
  sha256 "4724a343aaeed11e5f1d536c7afd85d368d1cb8bf739e7cba958a4b20bad6a18"
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
