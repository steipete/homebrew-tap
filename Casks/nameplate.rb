cask "nameplate" do
  version "0.3.1"
  sha256 "639e9eff1fc3e57a351a9cae4dc31eea5b3d6b730b5e21609eeebf48350f936f"

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
