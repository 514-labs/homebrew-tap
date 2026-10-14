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
  version "0.5.1345-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1345-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "e36572b5aa4f780089274cc6fa4f0e264a5cb7fe738ba65c0d2f569972f8b310"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1345-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "a73294dd9705b69d0fd8232990f30270efbfdbf60fe5ae344119c3b0e70313ad"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1345-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "3d5804182499abd3adc5e9da6762fee11c315a249c27a5b85f6b08fca30826e5"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1345-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "bdf95533787fc379a35cabe941eeb42c4aa4ed383ef901988a5ddf0421cf9179"
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
