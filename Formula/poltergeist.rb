require "language/node"

class Poltergeist < Formula
  desc "Universal file watcher with auto-rebuild for any language or build system"
  homepage "https://github.com/steipete/poltergeist"
  url "https://registry.npmjs.org/@steipete/poltergeist/-/poltergeist-1.6.0.tgz"
  sha256 "dda0cfd2ba8f4e513dfc59bb207d1b501140d72209898e619d9c2cfd7423a0ea"
  license "MIT"

  depends_on "node"
  depends_on "watchman"

  def install
    system "npm", "install", *Language::Node.std_npm_install_args(libexec)
    
    # Create wrapper scripts
    bin.install_symlink Dir["#{libexec}/bin/*"]
    
    # Install polter as a separate command
    (bin/"polter").write <<~EOS
      #!/bin/bash
      exec "#{Formula["node"].opt_bin}/node" "#{libexec}/lib/node_modules/@steipete/poltergeist/dist/polter.js" "$@"
    EOS
    
    # Make poltergeist the main command
    (bin/"poltergeist").write <<~EOS
      #!/bin/bash
      exec "#{Formula["node"].opt_bin}/node" "#{libexec}/lib/node_modules/@steipete/poltergeist/dist/cli.js" "$@"
    EOS
    
    # Ensure scripts are executable
    chmod 0755, bin/"polter"
    chmod 0755, bin/"poltergeist"
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

      Documentation: https://github.com/steipete/poltergeist
    EOS
  end

  test do
    system "#{bin}/poltergeist", "--version"
    system "#{bin}/polter", "--help"
    
    # Test that watchman dependency is available
    assert_match "version", shell_output("watchman version")
  end
end