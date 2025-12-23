require "language/node"

class Oracle < Formula
  desc "Bundle prompts + files for second-model review"
  homepage "https://github.com/steipete/oracle"
  url "https://github.com/steipete/oracle/releases/download/v0.7.4/oracle-0.7.4.tgz"
  sha256 "bf72e4bad190e5c71bcd18aceee28c21c9758c0f3334f907531809858a330a35"
  license "MIT"
  version "0.7.4"

  depends_on "node"

  def install
    system "npm", "install", *Language::Node.std_npm_install_args(libexec)
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/oracle --version")
  end
end
