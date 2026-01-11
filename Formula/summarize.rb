class Summarize < Formula
  desc "Link → clean text → summary"
  homepage "https://github.com/steipete/summarize"
  license "MIT"

  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/steipete/summarize/releases/download/v0.9.0/summarize-macos-arm64-v0.9.0.tar.gz"
    sha256 "07afde51c6efe0af64828ce8d5f10b157f8d3466b40bae1d07a392c9dc2ee80f"

    def install
      bin.install "summarize"
    end

    def post_install
      chmod 0755, "#{bin}/summarize"
    end
  else
    # Linux and other platforms: install via npm
    url "https://registry.npmjs.org/@steipete/summarize/-/summarize-0.9.0.tgz"
    sha256 "26fbd88ff5b2066c82293640e0a8692d0ea85bdb1f34fc967f0b570147913381"

    depends_on "node@22"

    def install
      system "npm", "install", "-g", "--prefix=#{libexec}", "#{cached_download}"
      bin.install_symlink "#{libexec}/bin/summarize"
    end
  end

  test do
    assert_match "0.9.0", shell_output("#{bin}/summarize --version 2>&1")
  end
end
