cask "nameplate" do
  version "0.3.0"
  sha256 "2d262f4051b736b6132a64b0495749709ec070b2f8ddc4c6537d9835dd841bbe"

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
