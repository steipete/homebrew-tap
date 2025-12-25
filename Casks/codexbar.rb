cask "codexbar" do
  version "0.14.0"
  sha256 "e41e31c81b79bcbc34bea8879432631b2f7a347be84f16be5015dbf5fd1c877e"

  url "https://github.com/steipete/CodexBar/releases/download/v#{version}/CodexBar-#{version}.zip",
      verified: "github.com/steipete/CodexBar/"
  name "CodexBar"
  desc "Menu bar usage monitor for Codex and Claude"
  homepage "https://codexbar.app/"

  depends_on arch: :arm64
  depends_on macos: ">= :sequoia"

  app "CodexBar.app"
  
  zap trash: [
    "~/Library/Application Scripts/com.steipete.codexbar.widget",
    "~/Library/Containers/com.steipete.codexbar.widget",
    "~/Library/Caches/com.steipete.codexbar",
    "~/Library/Caches/CodexBar",
    "~/Library/HTTPStorages/com.steipete.codexbar",
    "~/Library/HTTPStorages/com.steipete.codexbar.binarycookies",
    "~/Library/Group Containers/group.com.steipete.codexbar",
    "~/Library/Preferences/com.steipete.codexbar.plist",
    "~/Library/WebKit/com.steipete.codexbar",
  ]
end
