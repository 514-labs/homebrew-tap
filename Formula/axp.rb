# typed: false
# frozen_string_literal: true

# AUTO-GENERATED — do not edit by hand.
#
# Regenerated on every stable `axp` CLI release by the `publish-homebrew`
# job in 514-labs/axp's .github/workflows/release-cli.yml, via
# tooling/scripts/render-homebrew-formula.mjs. Hand edits are overwritten on
# the next release; change the generator instead.
#
# ENG-3612 deprecation window: `axp` is the old name for the `ax` CLI. This
# installs a byte-identical binary that prints a deprecation warning on every
# invocation; switch to `brew install 514-labs/tap/ax`.
class Axp < Formula
  desc "CLI for the 514 agent-experience platform"
  homepage "https://514.ax"
  version "0.5.1765-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1765-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "06ecbace9971c29867576074c9acb77842c3de536f6ed391bc59b77a9cdf99fc"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1765-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "77b85bbba9349087e9948755dd018d6610b1d71dea274bcd6ec29dc6bfa08291"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1765-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "ce8dad82df6a46779ed1a63e6a8da80aa89e7918514253c0bf98e982594dd0ee"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1765-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "e7df793696fe17316d3340af5b0b051f2d2dbef0c084667ac3af6b8f5cabe68a"
    end
  end

  def install
    # brew fetched (and sha256-verified) the per-arch archive
    # (`axp.tar.gz`), whose only member is the `axp` executable.
    bin.install "axp"
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
    # Keep the smoke test hermetic — `axp --version` otherwise pings the
    # update channel, which brew's test sandbox should not depend on.
    ENV["AXP_NO_UPDATE_CHECK"] = "1"
    assert_match version.to_s, shell_output("#{bin}/axp --version")
  end
end
