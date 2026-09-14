cask "nameplate" do
  version "0.4.0"
  sha256 "ee5468d6c6dedc0ae05f9ee979579f8b2c8f0f1a16de45b7f9e26d8e9a473716"

  url "https://github.com/steipete/Nameplate/releases/download/v#{version}/Nameplate-#{version}.zip"
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
