# typed: false
# frozen_string_literal: true

# AUTO-GENERATED — do not edit by hand.
#
# Regenerated on every stable `ax` CLI release by the `publish-homebrew`
# job in 514-labs/axp's .github/workflows/release-cli.yml, via
# tooling/scripts/render-homebrew-formula.mjs. Hand edits are overwritten on
# the next release; change the generator instead.
class Ax < Formula
  desc "CLI for the 514 agent-experience platform"
  homepage "https://514.ax"
  version "0.5.1769-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1769-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "b4e09e4a1d1dd6de7ca18fe1f3f6f3e82ab0c76d4cb4ef9f074c6f3bdf874461"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1769-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "11f1803adc61bc27408b00904043c37a749930bd999601ed222f74ebc0849688"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1769-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "694bb7679f2fb081427a149906c6f1dac00f4efc0132243e72ddfdb0d465264f"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1769-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "574127143b6998092db0bddcdfe4bd653b34a0a5ea1320c0ba5cb142a568320e"
    end
  end

  def install
    # brew fetched (and sha256-verified) the per-arch archive
    # (`ax.tar.gz`), whose only member is the `ax` executable.
    bin.install "ax"
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
    # Keep the smoke test hermetic — `ax --version` otherwise pings the
    # update channel, which brew's test sandbox should not depend on.
    ENV["AXP_NO_UPDATE_CHECK"] = "1"
    assert_match version.to_s, shell_output("#{bin}/ax --version")
  end
end
