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
  version "0.5.1274-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1274-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "b431dbb03909e0b4da7b54c8eb2659bea3951020166fae6ec570333ec4908ba0"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1274-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "4c71bdb4e89cb655126d17da1dba019174938254066745e0373e88ac04a591fd"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1274-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "33192195fb554c7e67abe50943dfed2499a80972487643db2b6a8b52abe31acc"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1274-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "46f71f98c693ff2c11310c383913589458da66830eee99570503b7303cd0c755"
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
