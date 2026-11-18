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
  version "0.5.1750-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1750-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "9f0646dd72b6a3b0fd30ca2d040c60705132a808a6f7638e885a99521efd131b"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1750-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "e741e96033f1c67d2870b74bd012241cb0c18f0f8ca3908ed9542218b12496d3"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1750-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "64890533ec63f138b6cfd434db0d0d9424f193d3faf4ba00ff412222266c108a"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1750-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "0d024117f261d2e1a37e0f193acc327f301cfd28a1a6be5a464626dd19f80a4b"
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
