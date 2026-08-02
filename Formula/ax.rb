# typed: false
# frozen_string_literal: true

# AUTO-GENERATED — do not edit by hand.
#
# Regenerated on every stable `ax` CLI release by the `publish-homebrew`
# job in 514-labs/axp's .github/workflows/release-cli.yml, via
# tooling/scripts/render-homebrew-formula.mjs. Hand edits are overwritten on
# the next release; change the generator instead.
class Ax < Formula
  desc "CLI for the 514 agent-experience platform"
  homepage "https://514.ax"
  version "0.5.592-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.592-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "a43fc72176547e7316cd19856cea5c24ccaa96fe238df3ce6ebcb09f086319d9"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.592-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "ae9d162c089486578b7004a61e0be02eb6c3d0817fa9fbf5b89b835d383f9a2e"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.592-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "0ead6920b49e7c526f475fc26c3ce1785891c23e8ddff48f77599f72c5fac9a3"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.592-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "adb5b799875d64fea0730292c5c831de723dad03c0f1e0ebdad2c589b7d07c14"
    end
  end

  def install
    # brew fetched (and sha256-verified) the per-arch relocatable archive
    # (`ax.tar.gz` = `ax` + libduckdb sidecar). Install the
    # members into libexec so they stay adjacent for $ORIGIN / @loader_path,
    # then symlink the executable onto PATH.
    libexec.install Dir["*"]
    bin.install_symlink libexec/"ax"
  end

  def caveats
    <<~EOS
      Sign in:
          https://app.514.ax/sign-in
          ax auth login --token <token>
      Then get oriented:
          ax auth status

      Next: walk your first experiment with `ax learn quickstart`

      Already have experiments? `ax experiment list`
    EOS
  end

  test do
    # Keep the smoke test hermetic — `ax --version` otherwise pings the
    # update channel, which brew's test sandbox should not depend on.
    # Clear loader path vars so the test exercises the archive's rpath
    # ($ORIGIN / @loader_path) rather than a host LD_LIBRARY_PATH.
    ENV.delete("LD_LIBRARY_PATH")
    ENV.delete("DYLD_LIBRARY_PATH")
    ENV.delete("DYLD_FALLBACK_LIBRARY_PATH")
    ENV["AXP_NO_UPDATE_CHECK"] = "1"
    assert_match version.to_s, shell_output("#{bin}/ax --version")
  end
end
