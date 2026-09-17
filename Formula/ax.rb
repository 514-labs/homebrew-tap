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
  version "0.5.1065-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1065-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "14d3f1bf84ad28bc50ec7ddf9343873a76ba3dbd50b99544523a0089445c4d7c"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1065-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "9241335a27b696f896d3a7624eccafee1eb96a8f58c1850931f961b7f0d2380a"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1065-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "d0d405e21e774e278abab657d424b1ec5fa57c5da0fd9b019265a6e6a90a692a"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1065-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "f9e24d06582214fbd834bcdb34f41414d1d1b6b3ca7ae561cd4a61aef1b82c55"
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

      Next: create your first experiment
          ax experiment create my-first-experiment --template cli-install   # see --help for the required flags

      Learn how to use ax: `ax learn`
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
