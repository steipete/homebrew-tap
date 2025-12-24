cask "codexbar" do
  version "0.13.0"
  sha256 "e638ff0d73e9abfaf8f48b84027a0984f51ed2cff24c1563b6f8b617a06c4e39"

  url "https://github.com/steipete/CodexBar/releases/download/v#{version}/CodexBar-#{version}.zip",
      verified: "github.com/steipete/CodexBar/"
  name "CodexBar"
  desc "Menu bar usage monitor for Codex and Claude"
  homepage "https://codexbar.app/"

  depends_on arch: :arm64
  depends_on macos: ">= :sequoia"

  app "CodexBar.app"
end
