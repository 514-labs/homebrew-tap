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
  version "0.5.1425-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1425-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "1e12a4d7e5735a231d96208cd9837b5e59bbd2949463b5bf00a1b1f721a6d3a3"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1425-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "11d75c60622afb7372dc3602694905519851696c714f373852f9cb7ab45798dc"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1425-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "03277512135bc77af5c6dbbb613e595be21ef58b788db87f1c844b2b1bc9cbb0"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1425-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "46dab35e858926f99c25f1d333b74b40ed74f6139bc75839923b9a3d06d65aeb"
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
