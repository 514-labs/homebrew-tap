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
  version "0.5.1485-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1485-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "f812796d993500aed884c11353b2107c5969a566a18ee6bc9703b652f7062c62"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1485-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "dd95feccedf5de8f3a87628e759747cd2fa91844dba8c831e5a41852058bbc3d"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1485-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "3acfa7575cb70394c16b16a25efd7706b11e8d47433be4537041c59a4936b3bf"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1485-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "81dc72a1179b81a60f48ae6d4f2e30f29fd49030f83eeae6b0b83a08b67eaead"
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
