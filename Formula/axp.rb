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
  version "0.5.1666-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1666-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "7debc86161e61fca78bd727c65d14459d23a2a687465d9696c149cb4701a6235"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1666-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "5e4d01c46f5350063d8a2de6c3f7d32bc3cdff9ec5b5306e0025e2f7494d32a3"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1666-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "2053c6d433f1c55bf447b57e954a9b698b0bd480b7486ada28142b298d5e092d"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1666-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "639e9feab8442337a57b1f7966f5bfd89809547d5839e96cd2c6eb71d8fd27dc"
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
