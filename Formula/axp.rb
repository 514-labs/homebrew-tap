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
  version "0.5.1344-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1344-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "6ee56f3dbeda6417e91dc076d038cbf647a4e710f8b32ca7b1a3a327f58a9b68"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1344-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "00e0f01544e68be0b9a2f3cec2c7595ce33539832a61b397842aad58b969ad66"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1344-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "3e5372dba184029c24dd651e988d6376c7f26d6d8440a09a7c3026da10671fd7"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1344-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "ab66468c13557c3891c7dbae3c743c3eb096b773e2106074be814efd8b3de756"
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
