require "language/node"

class Oracle < Formula
  desc "Bundle prompts + files for second-model review"
  homepage "https://github.com/steipete/oracle"
  url "https://github.com/steipete/oracle/releases/download/v0.7.6/oracle-0.7.6.tgz"
  sha256 "d84e8dcd387b9083633535ccf8ca8e95c286270fc547a3a13d4cd35a63069b84"
  license "MIT"
  version "0.7.6"

  depends_on "node"
  depends_on "pnpm" => :build

  def install
    system "npm", "install", *Language::Node.std_npm_install_args(libexec, ignore_scripts: false)
    bin.install_symlink Dir["#{libexec}/bin/*"]
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/oracle --version")
  end
end
