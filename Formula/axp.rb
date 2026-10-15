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
  version "0.5.1356-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1356-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "0d967f8d8720b97f8a4a7c96585dcd94b1d67433f43a863272aafb30c2144879"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1356-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "ef837e8c664e9b85852c6bcb5ad9254f249c88165ba30146a387af3a315d2839"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1356-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "9f1a8c5907a4ef24bfa1bd67aa0ce68f6fab58dde523be3a6d06a67fd21fa860"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1356-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "c40995a77b83bbc28a80b7ace9cb8c6c4b2e21d61aeab8488c30493ab65383c6"
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
