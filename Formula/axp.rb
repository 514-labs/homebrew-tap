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
  version "0.5.1229-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1229-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "d451c01452ebcde323448e90ec6773882487add1115591ce1bdd02c3c5d41aea"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1229-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "b97aca26320c9a842a9de73290e8818ea8a80549650ffa458da4cf0206842c03"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1229-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "5472554b813c0b55a0fc8517eba88ba65fd2fca8fc65e3faec1f59f161e05c56"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1229-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "7dc6b2a83c2a99c0baaa344607249930f8f7fc230e3ad99f53ea5978fe8e0c49"
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
