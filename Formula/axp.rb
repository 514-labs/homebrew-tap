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
  version "0.5.1493-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1493-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "b89f912eb87114373dc3d870f2af4b8ae503e6eb903f567ae5389d46ec5eab09"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1493-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "14d37f61157680533cd22a89c3900b683a61452108de4df7f9e0516ed44e4ee5"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1493-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "8a0ac5c260880d8d45c20c6cdb058c3f426920d89279ef58d4ebb3327469c2f8"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1493-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "e174a8186dc00a953c1e782d3907f0fcd7f44838edf17025b02177074e3779a0"
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
