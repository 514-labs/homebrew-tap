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
  version "0.5.1412-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1412-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "3c562332d886a6157efd61cce09adfb4ecb25f301244fdd2373464ecb3ad24c4"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1412-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "fdf6dab84ef76208389880bc288dbd88ff6a82dd64bbdb1f966c0eab09917325"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1412-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "19d4ca3dd5df2c037b0c0454bdda5f01c1a91020728527a9e16dea339c6d0e7e"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1412-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "b8808959fc2b38784216f9d3b5e6de65526694dd524bd0f109615c1525544831"
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
