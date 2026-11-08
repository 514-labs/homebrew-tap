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
  version "0.5.1684-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1684-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "6e0654e092ad5254a064729d6b8d06a8f38c51bc15c0be841d1002f908fda3ca"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1684-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "ee3c3ce6521f8a4622be330652e782823926719d5cab550b89b741b12e0ac0c0"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1684-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "18de496eb2bc2bd01c5cfc198703c29bf7c5c1be39cd78b2ec7199145c6b4360"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1684-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "dba7715909a0a7787b9c279cff83e03b7fd98ec4cf88d0b08c44a9ec167389c7"
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
