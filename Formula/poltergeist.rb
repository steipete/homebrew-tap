class Poltergeist < Formula
  desc "Universal file watcher with auto-rebuild for any build system"
  homepage "https://github.com/steipete/poltergeist"
  url "https://github.com/steipete/poltergeist/releases/download/v1.4.2/poltergeist-macos-arm64-v1.4.2.tar.gz"
  sha256 "23271b4df3779a4781cda36d4979538125078b4d9c7abc6adc322ba3d25440db"
  license "MIT"
  version "1.4.2"

  # ARM64 only for now
  depends_on arch: :arm64
  depends_on macos: :monterey

  def install
    bin.install "poltergeist"
    bin.install "polter"
  end

  def post_install
    # Ensure binaries are executable
    chmod 0755, "#{bin}/poltergeist"
    chmod 0755, "#{bin}/polter"
  end

  def caveats
    <<~EOS
      👻 Poltergeist has been installed!
      
      Quick Start:
      1. Create a poltergeist.config.json in your project:
         poltergeist init
      
      2. Start watching and auto-building:
         poltergeist haunt
      
      3. Use the shorthand command:
         polter status
      
      For more information:
        https://github.com/steipete/poltergeist
    EOS
  end

  test do
    # Test that the binary runs and returns version
    assert_match "1.4", shell_output("#{bin}/poltergeist --version")
    
    # Test polter wrapper
    assert_match "polter", shell_output("#{bin}/polter --help 2>&1")
    
    # Test init command generates config
    Dir.mktmpdir do |dir|
      Dir.chdir(dir) do
        system "#{bin}/poltergeist", "init", "--dry-run"
      end
    end
  end
end