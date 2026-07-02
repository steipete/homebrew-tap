cask "blackbar" do
  version "0.2.5"
  sha256 "068ff4ceb559a357f142b693fca2ffbc05057f5b9a2f634eb35693c252e4b5bc"

  url "https://github.com/steipete/BlackBar/releases/download/v#{version}/BlackBar-#{version}.zip",
      verified: "github.com/steipete/BlackBar/"
  name "BlackBar"
  desc "Menu bar app for Blacksmith CI status and live vCPU usage"
  homepage "https://black.bar/"

  livecheck do
    url :url
    strategy :github_latest
  end

  auto_updates true
  depends_on macos: :sonoma

  app "BlackBar.app"

  zap trash: [
    "~/Library/Application Support/BlackBar",
    "~/Library/Application Support/com.steipete.blackbar",
    "~/Library/Caches/BlackBar",
    "~/Library/Caches/com.steipete.blackbar",
    "~/Library/HTTPStorages/com.steipete.blackbar",
    "~/Library/Preferences/com.steipete.blackbar.plist",
    "~/Library/Saved Application State/com.steipete.blackbar.savedState",
  ]
end
