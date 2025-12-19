cask "trimmy" do
  version "0.6.3"
  sha256 "085bc6b35ede045128a83c77c7cbdd218e0f76f8deea8bcd419357f51afaa0e7"

  url "https://github.com/steipete/Trimmy/releases/download/v#{version}/Trimmy-#{version}.zip"
  name "Trimmy"
  desc "Paste-once, run-once clipboard cleaner for terminal snippets"
  homepage "https://github.com/steipete/Trimmy"

  depends_on arch: :arm64
  depends_on macos: ">= :sequoia"

  app "Trimmy.app"
end
