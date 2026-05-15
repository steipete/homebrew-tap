require "language/node"

class Oracle < Formula
  desc "Bundle prompts + files for second-model review"
  homepage "https://github.com/steipete/oracle"
  url "https://github.com/steipete/oracle/releases/download/v0.12.0/oracle-0.12.0.tgz"
  sha256 "257188c46a575aa69982cb9a3f6b6a5fda0922f136cd70646b04e4aab4206158"
  license "MIT"

  depends_on "pnpm" => :build
  depends_on "node"

  def install
    system "npm", "install", *std_npm_args
    bin.install_symlink Dir["#{libexec}/bin/*"]
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/oracle --version")
  end
end
