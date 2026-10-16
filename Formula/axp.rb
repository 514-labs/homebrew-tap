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
  version "0.5.1375-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1375-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "80c39fe087b3ea227ecc59670ed90b1bf993026aa9e42e66630017d5ce2d4c15"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1375-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "f60e657294c7d86db97f4bd1fae94cb365a5630056cbfd4fb65b3f0d214cf016"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1375-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "a2380aab0b208587dd998be1b765fdde5ee94651cbdd090a6a0069bf3e24bc5d"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1375-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "37322afd776f54c8cae7b92cf6911296eb890798caf03859b20d48b0a3c3f8d5"
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
