cask "codexbar" do
  version "0.11.0"
  sha256 "cb25bde5e7c6fe3a00c0be5bef77f2d7c693317c56d1582bf7ad2cc0664ee249"

  url "https://github.com/steipete/CodexBar/releases/download/v#{version}/CodexBar-#{version}.zip",
      verified: "github.com/steipete/CodexBar/"
  name "CodexBar"
  desc "Menu bar usage monitor for Codex and Claude"
  homepage "https://codexbar.app/"

  depends_on arch: :arm64
  depends_on macos: ">= :sequoia"

  app "CodexBar.app"
end
