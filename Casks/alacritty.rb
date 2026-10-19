cask "alacritty" do
  version "0.17.0"
  sha256 "ad8d7de35fb38e43184776cac6dfee05ca325caa0b6639a06a55e54e4b026620"

  url "https://github.com/alacritty/alacritty/releases/download/v#{version}/Alacritty-v#{version}.dmg"
  name "Alacritty"
  desc "GPU-accelerated terminal emulator"
  homepage "https://alacritty.org/"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on :macos

  app "Alacritty.app"
  binary "#{appdir}/Alacritty.app/Contents/MacOS/alacritty"

  # Upstream builds are not notarized; strip the quarantine flag so Gatekeeper doesn't block it.
  postflight_steps do
    run "/usr/bin/xattr", args: ["-dr", "com.apple.quarantine", "{{appdir}}/Alacritty.app"]
  end

  zap trash: [
    "~/.config/alacritty",
    "~/Library/Saved Application State/org.alacritty.savedState",
  ]
end
