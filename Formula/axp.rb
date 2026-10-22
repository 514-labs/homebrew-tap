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
  version "0.5.1457-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1457-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "322b0faccb5b818d62583bd348785f735460187c09d93e77604a68a5725854ae"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1457-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "38beec12ea501871f6e684cf9bf5f84d3c8c525a3949812b732c6393a74a2f91"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1457-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "44c79933ce3739319c8d87690671aa9a56433662687e206185c715878f99fbc1"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1457-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "4a38e73197c059f833b5f56368961f8f4da0b423c408c3ee6bd9adc67917fd29"
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
