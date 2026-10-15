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
  version "0.5.1367-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1367-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "2ed6b5b9a73e27bedecd031a8f243ef03616f104d87aa9284aaf2d182c1f26fb"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1367-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "9adce951290b8bb5da7e3fc8ab70b715b606f65ff67c6f90ddf568b2e6585ba7"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1367-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "d31c229339ab6afb603eb723349e4678c0ed9460659d56f99d03bf58939b55d5"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1367-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "4d58c6a100651fbf66c6a8500522b04dc12e205944b739c34be78bdef5959805"
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
