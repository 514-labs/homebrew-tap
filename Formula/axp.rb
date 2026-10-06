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
  version "0.5.1257-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1257-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "ade33cf3bb71c263bc163ec45cbcce69d97dd71605a3d232154cb9a29daa451a"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1257-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "ae9ce0bfb88086b0e02f31e0259a24258de832ee8a98dfdacfbeeae09485e619"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1257-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "bf58b1fb5f0200dabc9ef0d488b5e7eb3c43abdc65e700d571e64e177d9784c3"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1257-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "59e754f9f6cdca5189a760eb34141ff049bd949f9e98c30bdfefdd0bbd494283"
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
