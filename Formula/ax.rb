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
  version "0.5.1480-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1480-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "03baf17e9bcf1c628a5e9a02875d7fe8d4753c0a9dac6eeca11125a9adf29a14"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1480-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "71420b6e9a3e66b841ad2532f5d08376df6b90476cd9973a825989b44965acf4"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1480-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "f9682343b97bd71a6521fe03ad79469bc7119c64d01cbcf1987864c76601b5de"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1480-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "fdea6f900890aba9f35e8ccc17663f7c713d675f2fce2ed338536c1776d62687"
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
