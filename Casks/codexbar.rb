cask "codexbar" do
  version "0.12.0"
  sha256 "3fa5d8fec3c0673495bbb0fa29efe28355d79e1d7cac91874427b51bdb5314fa"

  url "https://github.com/steipete/CodexBar/releases/download/v#{version}/CodexBar-#{version}.zip",
      verified: "github.com/steipete/CodexBar/"
  name "CodexBar"
  desc "Menu bar usage monitor for Codex and Claude"
  homepage "https://codexbar.app/"

  depends_on arch: :arm64
  depends_on macos: ">= :sequoia"

  app "CodexBar.app"
end
