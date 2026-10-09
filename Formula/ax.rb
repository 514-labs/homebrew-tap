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
  version "0.5.1296-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1296-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "5c6cbc00a40c863e27ed33d8303f8cb70097ca7f3215e6beb48c3287095120a7"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1296-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "5a156ac070eec3eb2f0a500093b6c009867c4a337f8a2490acb693dcf07b9dd1"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1296-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "da4af8459292b4fca1e0aa16b646d662c6488c59244e6bac50a54782b5cadf21"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1296-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "ad835ee9e324fa71189b6217d7d18452fdaa9029075d3ba9310e9302f624fc7b"
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
