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
  version "0.5.1340-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1340-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "8e31b67627a9b7e7a8caaccfa8700c28a7bfab7ff5c553306a9822975be3da78"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1340-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "4e30674d6a922788f1479b492f5f1bec3664f68ffbf5276e93c37795415b0158"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1340-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "6dd673498b9bda5e91db08a6d7b4489ba5d1b1020ece5194b5f0a9e9f685c3bc"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1340-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "bedf30f69fc042b89cd33100c751bd055c12e26c6e2f93745f41f05d79fd52c0"
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
