cask "nameplate" do
  version "0.2.5"
  sha256 "96d1b6c58167b4a8f3713a61a7e216f8a24c2adad36c9027db974f852d543a3d"

  url "https://github.com/steipete/Nameplate/releases/download/v#{version}/Nameplate-#{version}.zip",
      verified: "github.com/steipete/Nameplate/"
  name "Nameplate"
  desc "Brand every computer in your fleet with click-through identity overlays"
  homepage "https://nameplate.sh/"

  depends_on arch: :arm64
  depends_on macos: :sequoia

  app "Nameplate.app"
  binary "#{appdir}/Nameplate.app/Contents/Helpers/nameplate"

  zap trash: [
    "~/Library/Caches/com.steipete.nameplate",
    "~/Library/HTTPStorages/com.steipete.nameplate",
    "~/Library/Preferences/com.steipete.nameplate.plist",
    "~/Library/Saved Application State/com.steipete.nameplate.savedState",
  ]
end
