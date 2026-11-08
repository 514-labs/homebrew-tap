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
  version "0.5.1689-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1689-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "500b87c3788bf457734c6967eda81bbed05278823e23ae2a1a5b0db7f35c389c"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1689-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "921ea91d9d5502b0b5bbf72d1930f95ff13dbee7253b43047a93791ff3960282"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1689-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "fa3d29e4ce944bf4cdd9128458af4a0ebec2016eb90d286968497e2ee24d8130"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1689-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "1b722bab8fd564beaadf09d322a0e832a24b3fc0bf0dbba58f992402d8920673"
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
