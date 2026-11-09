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
  version "0.5.1701-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1701-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "5aa0a8ba8a8bdd45f0ec30b843bd342c47fa27e6995cbb94f892fc0cb5a448f7"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1701-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "877e17eb4f426651019ffeed7985900a5739c12adf191975e9e8db7148425327"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1701-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "1d158ac5503b2014e8f3e1ca1d1d530f3c03a238fa7d5b22267fb75eea5f6b2e"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1701-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "9b0b82ca9fadacaed22e6cb25a0a3b700ff8d0ffb9b9e5c7852921a063e5915a"
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
