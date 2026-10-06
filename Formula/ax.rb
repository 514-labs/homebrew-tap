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
  version "0.5.1251-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1251-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "087091a502f85328aaba4467b2f2c4a70976bfc78b4f040cec73c3f568033870"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1251-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "bbd044aacb5b9856222457ea42ccb42e804ed93515b1073e9ca7518eddbb2e53"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1251-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "ccb16b9b434fbe27558be181ae3ab48593a8d5f687febd2327f7c037d1e03060"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1251-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "826215aed4cdbb25c19a0bd13812a2d15f27626db9819e929c51280cbd898aee"
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
