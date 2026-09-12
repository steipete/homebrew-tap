cask "codexbar" do
  version "0.60.0"
  sha256 "47ea112e514c665ab1dc5e390b5aa60563f8436b4aae9e1642fb7003f92aaf00"

  url "https://github.com/steipete/CodexBar/releases/download/v#{version}/CodexBar-macos-universal-#{version}.zip"
  name "CodexBar"
  desc "Menu bar usage monitor for Codex and Claude"
  homepage "https://codexbar.app/"

  auto_updates true
  depends_on macos: :sonoma

  app "CodexBar.app"
  binary "#{appdir}/CodexBar.app/Contents/Helpers/CodexBarCLI", target: "codexbar"

  zap trash: [
    "~/Library/Application Scripts/com.steipete.codexbar",
    "~/Library/Application Scripts/com.steipete.codexbar.widget",
    "~/Library/Application Support/CodexBar",
    "~/Library/Application Support/com.steipete.codexbar",
    "~/Library/Caches/CodexBar",
    "~/Library/Caches/com.steipete.codexbar",
    "~/Library/Containers/com.steipete.codexbar",
    "~/Library/Containers/com.steipete.codexbar.widget",
    "~/Library/Group Containers/group.com.steipete.codexbar",
    "~/Library/HTTPStorages/com.steipete.codexbar",
    "~/Library/HTTPStorages/com.steipete.codexbar.binarycookies",
    "~/Library/Preferences/com.steipete.codexbar.plist",
    "~/Library/Saved Application State/com.steipete.codexbar.savedState",
    "~/Library/WebKit/com.steipete.codexbar",
  ]
end
