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
  version "0.5.1627-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1627-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "b93c729d0fc7d520f7fcacc246791543e1505c67b0045c3a44d5cda8aedba541"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1627-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "7932223715d7670d00f004a8431abd95b1c57756036d79af27323a0acb06e7a2"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1627-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "be1413ef2ca3254ede4fde3a58b10f32deb5b8e9eac2ffed10b23e6208cd384a"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1627-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "35a0746e4cfbe05f2c7431766ca09361fc272f72e8c69fe6106cc1d9caf7fdad"
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
