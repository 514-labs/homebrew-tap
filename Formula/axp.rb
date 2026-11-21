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
  version "0.5.1781-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1781-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "b6e10e552c7ab4d030228138547554b12ed4065d01d219ccbea1b396cf335c39"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1781-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "655342f4b269bb41411add2fc12c1db029ef6b05be4dfbae8f6bcd04666cd32b"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1781-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "b218f145bac15a6b26d6f5df0039096f72e3eff93b4a8fd4c1d502c7f621b4b3"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1781-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "ccd07c774a1feec8085bab2e840ba5534f22c94a3ab80ce8f0950c4fc07cc21f"
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
