cask "nameplate" do
  version "0.5.0"
  sha256 "8cc62afdad561c9b511522a3fb26dfef9c1a7dc3d513ee0bcead96d0bfc8c07a"

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
