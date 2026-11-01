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
  version "0.5.1623-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1623-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "5be2dfaed15b947685031ef0d4806b5c5bf5ec7a18c218b543a99e28aa0827e1"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1623-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "55d9faa350facb0c61edaed04b7729b97e94f5858b4c3e4525f84e78f43f0230"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1623-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "84f46666deef0c83034c32a6f0524a6d19c563be28ccd0bd44aeaa63d47b5d59"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1623-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "04dc2a8da1c765703e74ef3d4a535d177720136d17065d1fd822586752cd8dd7"
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
