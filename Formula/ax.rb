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
  version "0.5.1661-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1661-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "0ff29208a5ae8aa458bd4079c6783218f555fcec540f296de894857a2cc9fda6"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1661-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "020f2e97dbd3d7b1b91a593e6d0925dddb5aa8a2b3bee443267cfa0abbaa6811"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1661-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "e8d3c34b5f23b861a5ee141d1ca14683760214378988fee720581f2d9a880dde"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1661-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "0d3d4b44fecb5ec3807252146c75252696c97d70bdaf5c304438a44be10dea65"
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
