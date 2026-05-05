cask "repobar" do
  version "0.4.1"
  sha256 "c1acbd3c717a5837afd535058681d782b6494a438f1f2cccd3918fc16a6e9110"

  url "https://github.com/steipete/RepoBar/releases/download/v#{version}/RepoBar-#{version}.zip",
      verified: "github.com/steipete/RepoBar/"
  name "RepoBar"
  desc "Menu bar dashboard for GitHub repository health"
  homepage "https://repobar.app/"

  depends_on macos: ">= :sequoia"

  app "RepoBar.app"
  binary "#{appdir}/RepoBar.app/Contents/MacOS/repobarcli", target: "repobar"

  zap trash: [
    "~/Library/Application Support/RepoBar",
    "~/Library/Application Support/com.steipete.repobar",
    "~/Library/Caches/RepoBar",
    "~/Library/Caches/com.steipete.repobar",
    "~/Library/HTTPStorages/com.steipete.repobar",
    "~/Library/Preferences/com.steipete.repobar.plist",
    "~/Library/Saved Application State/com.steipete.repobar.savedState",
  ]
end
