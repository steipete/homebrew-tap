cask "repobar" do
  version "0.1.1"
  sha256 "c4f8dda18861505b1fc2e17fa310ce15b79ecd584dd319a4251dd04fe448ccd0"

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
