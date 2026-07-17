class Poltergeist < Formula
  desc "Universal file watcher with auto-rebuild for any language or build system"
  homepage "https://github.com/steipete/poltergeist"
  url "https://github.com/steipete/poltergeist/releases/download/v2.1.3/poltergeist-macos-universal-v2.1.3.tar.gz"
  sha256 "272d778a68d969c4cbe50ef8d4a6068ae28932416ddd66554fa59a602ddf7d0d"
  license "MIT"

  depends_on "watchman"

  def install
    bin.install "poltergeist"
    bin.install "polter"
  end

  def post_install
    # Ensure binaries are executable
    chmod 0755, bin/"poltergeist"
    chmod 0755, bin/"polter"
  end

  def caveats
    <<~EOS
      Poltergeist has been installed with two commands:
        poltergeist - Main CLI for managing file watching and builds
        polter      - Smart executor for running fresh binaries

      To get started:
        1. Create a poltergeist.config.json in your project
        2. Run 'poltergeist init' to generate a config
        3. Run 'poltergeist start' to begin watching
        4. Use 'polter <target>' to run your binaries

      Watchman is required and has been installed as a dependency.

      Documentation: https://github.com/steipete/poltergeist
    EOS
  end

  test do
    # Test that the binary runs and returns version
    assert_match version.to_s, shell_output("#{bin}/poltergeist --version")

    # Test polter wrapper
    assert_match "Poltergeist", shell_output("#{bin}/polter --help")

    # Test that watchman dependency is available
    assert_match "version", shell_output("watchman version")
  end
end
