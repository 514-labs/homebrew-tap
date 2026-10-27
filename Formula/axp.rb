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
  version "0.5.1498-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1498-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "2c276595f0a7b990ecb6a8a01cd3248cf59faeab220929d52c3c912c8c421829"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1498-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "27495eea223f76a138431b6278c9f2c58e6f2d71128e47994c0f4db3c366a34a"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1498-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "840380b336a5d51c18951b6a9652f207dea7825b523035854d93e10c7b6b41c3"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1498-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "3aa08e7129f4b9f667b6a307260f4bd6c84b6d6ecc4167c753b25555d5c5aaec"
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
