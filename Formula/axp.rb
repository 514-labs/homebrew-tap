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
  version "0.5.1427-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1427-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "f67b19f4b25307848cad1135a60a5217b7d36bce3712a5feb822be9f765e30d0"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1427-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "31a8a726eb3823f5d3049acec0b7269334c87e91350a3ccf6b2aa1515b5e6236"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1427-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "c8f0cc0ed91a2239b961bfa6e1ac99acc6d782130ef37492d62d62c0dc10c72b"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1427-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "35574628b8fd75a2b77b542a6827d154fc49186d8565339f18fe5657f4f05056"
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
