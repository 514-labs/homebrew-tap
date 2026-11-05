# typed: false
# frozen_string_literal: true

# AUTO-GENERATED — do not edit by hand.
#
# Regenerated on every stable `ax` CLI release by the `publish-homebrew`
# job in 514-labs/axp's .github/workflows/release-cli.yml, via
# tooling/scripts/render-homebrew-formula.mjs. Hand edits are overwritten on
# the next release; change the generator instead.
class Ax < Formula
  desc "CLI for the 514 agent-experience platform"
  homepage "https://514.ax"
  version "0.5.1647-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1647-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "a545f506d46307df18fbf0b13e40b6bb72ff821e07fe61a53134519769a7b0d2"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1647-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "8ae7298ec858b18ed61b8823dbd337b731e6fe59eebcd6cd207c2d447fe9f2de"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1647-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "d74be719b19af15a058da1adb495a3b9053fcc65f19cae22002beec74525b58b"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1647-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "2df95b9bce19b4a240eb2cdf40617f817430966aeefdabe0edff1d4f2572cbcb"
    end
  end

  def install
    # brew fetched (and sha256-verified) the per-arch archive
    # (`ax.tar.gz`), whose only member is the `ax` executable.
    bin.install "ax"
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
    # Keep the smoke test hermetic — `ax --version` otherwise pings the
    # update channel, which brew's test sandbox should not depend on.
    ENV["AXP_NO_UPDATE_CHECK"] = "1"
    assert_match version.to_s, shell_output("#{bin}/ax --version")
  end
end
