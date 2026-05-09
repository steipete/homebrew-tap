require "language/node"

class Mcporter < Formula
  desc "Model Context Protocol runtime and CLI generator"
  homepage "https://github.com/openclaw/mcporter"
  url "https://github.com/openclaw/mcporter/releases/download/v0.10.2/mcporter-0.10.2.tgz"
  sha256 "fedf0974ad84b78183c48caada7faf773dbed3100530765d7a6c503dc4f5b016"
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
