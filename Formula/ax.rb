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
  version "0.5.1763-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1763-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "0d0af37300b25611e1b00ff2565bc4b4f719efb4a6196d725ebdef87bb7a01a7"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1763-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "5bc3f47d6abbb51714547bd3bfeb0edf9336a47a7c1041303a9343fe6d1c88b6"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1763-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "aa697b302bf245ca2de2141ed4723a8fbaae7ac2370462e4e42f53cf5b0d0890"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1763-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "daf4a387120de90bd7e63fa18bce0f4c028cf7eaff324194e80c6991e491c2ca"
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
