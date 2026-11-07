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
  version "0.5.1676-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1676-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "b33cabcd986b54477ab27b86318442506611ce298fbfd4bc0e04ea6a6f3c16cb"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1676-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "c53e15f4309ea0995791e7e239a580a3e2980a0ac17d14cb46180172e14b3a2a"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1676-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "e006cbae532768a6f244bd65e851882590923bfac17f187b1240a20ac49f43b0"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1676-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "9dbd089b5ff68d681f901690f71ff44c73a9cc1bea4ef4941c7fc8f1e5ad5817"
    end
  end

  def install
    # brew fetched (and sha256-verified) the per-arch archive
    # (`ax.tar.gz`), whose only member is the `ax` executable.
    bin.install "ax"
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
    ENV["AXP_NO_UPDATE_CHECK"] = "1"
    assert_match version.to_s, shell_output("#{bin}/ax --version")
  end
end
