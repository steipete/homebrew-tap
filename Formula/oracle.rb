require "language/node"

class Oracle < Formula
  desc "Bundle prompts + files for second-model review"
  homepage "https://github.com/steipete/oracle"
  url "https://github.com/steipete/oracle/releases/download/v0.21.1/oracle-0.21.1.tgz"
  sha256 "63c27794bcb3da0ce3169cb69c35658171eba23b5c926b85b7916101a1e02d0d"
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
