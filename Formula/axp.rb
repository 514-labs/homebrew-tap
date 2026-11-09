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
  version "0.5.1702-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1702-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "834e6395bdb8414e616d37ac6042833ae457643459b7246ef8bcf57c5da56457"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1702-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "cba6224bf226067c6604518faa88222ee6daeb4fec9079f9387964f500409dca"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1702-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "8394694933784dfe0bab94bd86204ab056deb57cdbbd7dc5997f498a09fe2055"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1702-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "d0d51e9607909e9b4ab9898f579035bd45adba94c0321004f5dc2e9993d97077"
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
