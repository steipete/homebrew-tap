require "language/node"

class Oracle < Formula
  desc "Bundle prompts + files for second-model review"
  homepage "https://github.com/steipete/oracle"
  url "https://github.com/steipete/oracle/releases/download/v0.16.1/oracle-0.16.1.tgz"
  sha256 "7da94d901eed8bc89652f1f7c6943197d88423576b59d9ec81cd9f85183e9786"
  license "MIT"

  depends_on "pnpm" => :build
  depends_on "node"

  def install
    system "npm", "install", *std_npm_args
    # The npm tarball vendors an x86_64 macOS notifier that is not used by the CLI.
    rm_r Dir["#{libexec}/lib/node_modules/@steipete/oracle/node_modules/toasted-notifier/vendor/mac.noindex"]
    bin.install_symlink Dir["#{libexec}/bin/*"]
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/oracle --version")
  end
end
