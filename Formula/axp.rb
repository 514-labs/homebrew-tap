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
  version "0.5.1516-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1516-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "04d1f97c2c646bb115d7ea725bc77d4bdc21a707a0fa6e2347f394356b34a7a5"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1516-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "a477949b7a9d795e0d006cd154a7347a4629c817453f3e75eda09e78c0d45aab"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1516-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "8143c53729268dd70ac8dd8440a15e8ec4df01dbcd638526f5aafc60a2c451bc"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1516-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "b426c912ec388a7a4fdfb6f9ad2ee7bd21738f351baca4a90b03f84329fae704"
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
