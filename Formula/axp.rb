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
  version "0.5.1787-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1787-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "18afdbe239b6c2652562d601260514f61866639fc1458251d25be297112a02c0"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1787-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "61c0f110cd1f4a0f195d35e6f2fe9f5040946bbbf318cc01c8552ca4cfac426d"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1787-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "b1717008be62a2102101351f2f16ad67eb1f3a2311d91424a39eeda4e7bdf767"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1787-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "6f3794dba0ac95487062b37ba7c27325b0f42e590f66600bad5cb7ced78853f4"
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
