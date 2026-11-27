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
  version "0.5.1795-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1795-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "0741f14f12b9a23eece3a456dd0f1eda7d607a64c2beff57d208364a7e6991f5"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1795-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "cdf55c1f04d906e2be7ee378be5df9e8f9fe7f05c9e57a9484547ac4344637b5"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1795-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "7c4f4b0933a124ea7623efcd498bed0b5682b7dbb6e18c1dd9550c21bad0499f"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1795-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "8a84cf05db3ce81a79b6fd8d4ec5cd67c8f5c4bc87e534f0f4e3ff814acb2823"
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
