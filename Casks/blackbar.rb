cask "blackbar" do
  version "0.3.4"
  sha256 "691260ed93e8232489b5cbde362504083f54ffcc1199023cb83ae1db341d7816"

  url "https://github.com/steipete/BlackBar/releases/download/v#{version}/BlackBar-#{version}.zip"
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
