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
  version "0.5.1266-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1266-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "96597a0f05ec8a2e6105ad2044b876e30fbdf824d88cbc1dedaab5515106d105"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1266-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "4a31a2eb3c203d5d1bee16ac14edee831646dbd5aa34c5239137365327cd60a8"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1266-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "a49cb54a7600d21a8f9e7de605781aa5b30aebdafb19fa71e3fa5895134132fc"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1266-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "e5534b444acd7fa0a891f87d3250c525d5cd686a460678be63b047ff74eab232"
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
