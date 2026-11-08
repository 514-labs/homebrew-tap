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
  version "0.5.1688-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1688-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "7278faf339fb5ef362c1555fde38392d39bb1d55c0a586eb4524c4c89bed5e47"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1688-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "d255689b5b8bf41b8a7a3e1c079de44978a4afcead2e55351cfdf78300a35ab5"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1688-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "8f69f0e759ed97891af3eb185ec07de96378f6cc3b88b002be7a81a4c8337783"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1688-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "43dc226dd3dd794789622fbcabac4a6104cc3619460f0b03654990cc4ab6d7e2"
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
