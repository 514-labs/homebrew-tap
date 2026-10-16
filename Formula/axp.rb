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
  version "0.5.1393-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1393-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "b874f9906d5534c4ca13298560a9e8cccea613067f30556af58ee416e42259a9"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1393-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "4179607006b60ab5c65ae7b85197c17a4ca0816825639aa997fe5160eb58226a"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1393-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "b7dbd7e13a7b011006ce04a034651cce8e990341520dc488476c7a7fbef1d022"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1393-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "0a35e1a5faf78fefa4da764058b908976a4ec406cac8e73afcacbdb160cff137"
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
