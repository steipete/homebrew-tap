cask "codexbar" do
  version "0.8.0"
  sha256 "1d44c205b652fa0ac8a6f94090242f5c52ba574f4b03be691af1d3ee767e5573"

  url "https://github.com/steipete/CodexBar/releases/download/v#{version}/CodexBar-#{version}.zip",
      verified: "github.com/steipete/CodexBar/"
  name "CodexBar"
  desc "Menu bar usage monitor for Codex and Claude"
  homepage "https://codexbar.app"

  depends_on arch: :arm64
  depends_on macos: ">= :sequoia"

  app "CodexBar.app"
end
