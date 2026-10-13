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
  version "0.5.1338-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1338-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "b5e1dfcdaefacf2baff5ac281da4553b028f936f48b7b7fe9601b388d986e001"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1338-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "22c8449939277cc853857b9dd2e8002057d5d2aaedfb0d1d5798030a39b0608a"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1338-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "69d594795f6adff97a84209727ac5cc44e75b966c152030e0f6312829cfcea66"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1338-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "2a6b45d601e4ea9954ddee7efc53d1ff57651682bf1f94cc9a8dd614ca9997d8"
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
