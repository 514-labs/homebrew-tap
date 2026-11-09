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
  version "0.5.1696-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1696-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "52ff5711093e387ed213c977856e516e8326177afa74fe52b4008aa850d387d6"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1696-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "c88059538e8fa086bfad7d7a9d30635d093b8912fe9205ebe1f616338fd15591"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1696-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "bb78b4b3f55a29839a176595a7afdf187dc172210be5006b09969ccfe3ed33ec"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1696-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "47e9321753dadd85828e738beac0b471680b311e68394851a6b48905ecf9959d"
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
