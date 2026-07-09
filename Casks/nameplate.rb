cask "nameplate" do
  version "0.2.3"
  sha256 "550db489ad392b9b58f4c1e5255c6daf961a08a3d40b5b32b22b5c8f175efca2"

  url "https://github.com/steipete/Nameplate/releases/download/v#{version}/Nameplate-#{version}.zip"
  name "Nameplate"
  desc "Brand every Mac in your fleet with click-through identity overlays"
  homepage "https://nameplate.sh"

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
