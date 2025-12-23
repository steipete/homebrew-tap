require "language/node"

class Oracle < Formula
  desc "Bundle prompts + files for second-model review"
  homepage "https://github.com/steipete/oracle"
  url "https://github.com/steipete/oracle/releases/download/v0.7.5/oracle-0.7.5.tgz"
  sha256 "df383458a18b78804cf90c22ec1f831778c80b47f287ce19c47a71581833ce5d"
  license "MIT"
  version "0.7.5"

  depends_on "node"

  def install
    system "npm", "install", *Language::Node.std_npm_install_args(libexec, ignore_scripts: false)
    bin.install_symlink Dir["#{libexec}/bin/*"]
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/oracle --version")
  end
end
