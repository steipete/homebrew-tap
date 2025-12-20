cask "codexbar" do
  version "0.10.0"
  sha256 "8099e57a3dcf0c9cc11ece46940e40930c8d97fc72723dd855a96558ea258e11"

  url "https://github.com/steipete/CodexBar/releases/download/v#{version}/CodexBar-#{version}.zip",
      verified: "github.com/steipete/CodexBar/"
  name "CodexBar"
  desc "Menu bar usage monitor for Codex and Claude"
  homepage "https://codexbar.app/"

  depends_on arch: :arm64
  depends_on macos: ">= :sequoia"

  app "CodexBar.app"
end
