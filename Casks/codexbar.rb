cask "codexbar" do
  version "0.9.0"
  sha256 "28296477d7d14e124df124c5080406ffdacaf88745cc023dc5e9c6f38a0e4413"

  url "https://github.com/steipete/CodexBar/releases/download/v#{version}/CodexBar-#{version}.zip",
      verified: "github.com/steipete/CodexBar/"
  name "CodexBar"
  desc "Menu bar usage monitor for Codex and Claude"
  homepage "https://codexbar.app/"

  depends_on arch: :arm64
  depends_on macos: ">= :sequoia"

  app "CodexBar.app"
end
