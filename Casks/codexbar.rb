cask "codexbar" do
  version "0.82.0"
  sha256 "b8f4bc3a42e07d23ad3621d89961892c28228310589118228d0620ce45cae4aa"

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
