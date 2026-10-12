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
  version "0.5.1328-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1328-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "750660eb842d4d433a2bea2461d80610500b8527a203c97cf6271e36e4c6f458"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1328-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "9c6bf9098940390d130b8431e60bfa8986d3ab6d679e0d06beaed9e98c9f89ac"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1328-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "eec423c94ac3058ebdd3127a77bac50507d1b937fb837c9c49edea42203f9979"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1328-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "9a5a0cbe640dc870d5cce1f0b21658175a48325a6f12479008322809891c8d8b"
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
