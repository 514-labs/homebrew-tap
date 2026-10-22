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
  version "0.5.1461-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1461-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "be2bf71fa3bf6f5049f0c86220f0bc29de5920fbed10413ddcf06747c095a153"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1461-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "51fe1f9921166fdd67bd004ebfdec67e64bfa61a8f4231f9173c83998458e51a"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1461-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "073ce3ac4b250ea1a66def4c1f1d58fb21e88d6e85db629cd50e945d089ba6fd"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1461-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "d55f54138838de115dd97524fac795f4508af248d63187b8f47958ecc3ae11c3"
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
