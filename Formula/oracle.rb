require "language/node"

class Oracle < Formula
  desc "Bundle prompts + files for second-model review"
  homepage "https://github.com/steipete/oracle"
  url "https://github.com/steipete/oracle/releases/download/v0.14.0/oracle-0.14.0.tgz"
  sha256 "03b84c6673f14b915d104e97cc19ccbcd4923137ebe0df7dfd4b486ae4b443ef"
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
