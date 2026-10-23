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
  version "0.5.1470-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1470-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "0fd11d20d3563c5cbc04c84cfe99e3fa117ff2dc8b27b48d41d2aa66e9adaada"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1470-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "7e07ecbc6bf162392ce19571661ebd42bd86b1e6e616c921abdaa6aa430c9dd2"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1470-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "a447303cd4459ea7d1d7a193d88de660d828d9b97ffaa1947d90bb1086cc099e"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1470-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "586047c2cb80d2f8ef3639ef20112616880e0dfa7e0bcd11728d8065d0f5de4d"
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
