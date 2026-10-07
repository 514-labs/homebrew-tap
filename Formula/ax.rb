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
  version "0.5.1269-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1269-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "af76ada939595e8526d0ff5ca7dc11165ee14806309b7cc0a1a96ef275d65a4d"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1269-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "e503888a0c747aa1b4b466c981a25c8aaaeb3a95d2025239d75ace4d6747dde4"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1269-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "8e6e9a724bf6a8e5cfca6c2cc99d309272a96f5f4a64ce1b258f6c43147fec6f"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1269-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "3c5e95c8b2a6239e6cde9255bc33e1b82c0a2c32f031f439adb3184c71d0bdb5"
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
