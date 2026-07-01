class Imsg < Formula
  desc "Send and read iMessage / SMS from the terminal"
  homepage "https://github.com/openclaw/imsg"
  url "https://github.com/openclaw/imsg/releases/download/v0.12.0/imsg-macos.zip"
  sha256 "e96419df17a8d95cd5ab097bca257c35dc82bace0d4b693226f012eb76cb64e5"
  license "MIT"

  # macOS Sonoma (14.0) or later required
  depends_on macos: :sonoma

  def install
    libexec.install "imsg"
    libexec.install "imsg-bridge-helper.dylib" if File.exist?("imsg-bridge-helper.dylib")
    Dir["*.bundle"].each do |bundle|
      libexec.install bundle
    end
    rm bin/"imsg" if (bin/"imsg").exist?
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
