cask "codexbar" do
  version "0.11.1"
  sha256 "7d9135d516952e7a36546697fc765f16739559d008d76d893cbffbaa8b09751a"

  url "https://github.com/steipete/CodexBar/releases/download/v#{version}/CodexBar-#{version}.zip",
      verified: "github.com/steipete/CodexBar/"
  name "CodexBar"
  desc "Menu bar usage monitor for Codex and Claude"
  homepage "https://codexbar.app/"

  depends_on arch: :arm64
  depends_on macos: ">= :sequoia"

  app "CodexBar.app"
end
