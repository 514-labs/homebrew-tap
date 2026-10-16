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
  version "0.5.1396-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1396-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "50a9b9fc489821c34c0c2827d8a66958299d01c5e6f89966525e630b7fec4e6a"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1396-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "93d63ffacdc6542a14d8b025ac4d831f7978933ff449e0a869e5e260073c103e"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1396-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "2357c6800c9b88645658bfaa58eed701b047784eed389dac5521739f8826f2bb"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1396-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "9db4c4b6acf9c5fc472273a08ca95406710b8e7ad67de447fc7fc4ed853164d6"
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
