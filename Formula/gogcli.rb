class Gogcli < Formula
  desc "Google CLI for Gmail, Calendar, Drive, and Contacts"
  homepage "https://github.com/steipete/gogcli"
  url "https://github.com/steipete/gogcli/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "73b679683a6c043d3196dcfc4e21cd054ed7748ac59ed69985390d0ac9600281"
  license "MIT"
  version "0.1.0"

  depends_on "go" => :build

  def install
    system "go", "build", *std_go_args(ldflags: "-s -w"), "./cmd/gog"
  end

  test do
    assert_match "Google CLI", shell_output("#{bin}/gog --help")
  end
end

