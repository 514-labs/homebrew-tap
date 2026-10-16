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
  version "0.5.1380-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1380-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "682a4f77f8496d6575479262cec073fa034e0483f864b41bb3c9adc7c767d2f3"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1380-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "32d3c44a68d4731951ed37c1657d67cc2f7ad4316912b0ca673912b27fe88412"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1380-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "677068b6c48d2fd5df83dbb6fe58b1f9af5831244658d4b5ebb56f3469eb3e0d"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1380-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "e2a83da3e85ee2a8191c3c91ef2de14752736e510b7cbc6d25cd9d963595bbe2"
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
