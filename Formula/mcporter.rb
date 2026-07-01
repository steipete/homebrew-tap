require "language/node"

class Mcporter < Formula
  desc "Model Context Protocol runtime and CLI generator"
  homepage "https://github.com/openclaw/mcporter"
  url "https://github.com/openclaw/mcporter/releases/download/v0.12.3/mcporter-0.12.3.tgz"
  sha256 "9cf707fac46fdf69c27e67b9e29b866e7bb51d98266671c4282fdfed66569751"
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
