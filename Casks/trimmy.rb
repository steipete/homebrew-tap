cask "trimmy" do
  version "0.6.2"
  sha256 "7f657f4a31bf04769f45527a22d8eb1606879dfcfbb346d70d587f041fbf4e2f"

  url "https://github.com/steipete/Trimmy/releases/download/v#{version}/Trimmy-#{version}.zip",
      verified: "github.com/steipete/Trimmy/"
  name "Trimmy"
  desc "Paste-once, run-once clipboard cleaner for terminal snippets"
  homepage "https://github.com/steipete/Trimmy"

  depends_on arch: :arm64
  depends_on macos: ">= :sequoia"

  app "Trimmy.app"
end

