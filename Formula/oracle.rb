require "language/node"

class Oracle < Formula
  desc "Bundle prompts + files for second-model review"
  homepage "https://github.com/steipete/oracle"
  url "https://github.com/steipete/oracle/releases/download/v0.10.0/oracle-0.10.0.tgz"
  sha256 "e6feeb7c75472c1364ef1a3bd16d87ed1d8965f39a7b80a49fac1b35efbdf09b"
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
