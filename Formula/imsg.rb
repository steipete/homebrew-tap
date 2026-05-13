class Imsg < Formula
  desc "Send and read iMessage / SMS from the terminal"
  homepage "https://github.com/openclaw/imsg"
  url "https://github.com/openclaw/imsg/archive/refs/tags/v0.8.2.tar.gz"
  sha256 "08d02d69ca69f3f6b7743ea81051dfc73d0720bbd0fb21c38a30671505cf4678"
  license "MIT"

  # macOS Sonoma (14.0) or later required
  depends_on xcode: ["16.0", :build]
  depends_on macos: :sonoma

  uses_from_macos "swift" => :build

  def install
    ENV["OUTPUT_DIR"] = buildpath/"dist"
    ENV["CODESIGN_IDENTITY"] = "-"

    inreplace "scripts/build-universal.sh",
      'swift build -c "$BUILD_MODE" --product "$APP_NAME" --arch "$ARCH"',
      'swift build --disable-sandbox -c "$BUILD_MODE" --product "$APP_NAME" --arch "$ARCH"'

    system "scripts/generate-version.sh"
    system "swift", "package", "--disable-sandbox", "resolve"
    system "scripts/patch-deps.sh"
    system "scripts/build-universal.sh"

    libexec.install "dist/imsg"
    lib.install "dist/imsg-bridge-helper.dylib" if File.exist?("dist/imsg-bridge-helper.dylib")
    Dir["dist/*.bundle"].each do |bundle|
      libexec.install bundle
    end
    bin.write_exec_script libexec/"imsg"
  end

  def caveats
    <<~EOS
      imsg needs Full Disk Access to read the Messages database.

      To grant permission:
      1. Open System Settings > Privacy & Security > Full Disk Access
      2. Enable access for your Terminal application

      To send messages, allow Terminal to control Messages.app:
      System Settings > Privacy & Security > Automation

      Advanced IMCore bridge features also require SIP disabled. The formula
      installs the bridge helper automatically when the release archive ships it.
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/imsg --version")
    assert_match "Send and read iMessage", shell_output("#{bin}/imsg --help")
  end
end
