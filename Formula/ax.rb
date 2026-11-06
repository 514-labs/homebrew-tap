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
  version "0.5.1675-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1675-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "e02977b6dbb748eba9b8c0508351ba0ac92f814dc9bf0b11544bc10e3ece0452"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1675-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "7d309b19a93bbcc0a1f580a6f7e06aeb52c4d837b37cb9e804d2c3ad2555c7e8"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1675-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "f29eafd98407ae34cf90e53415143c2d1c35c9dcfcc7e2b6914a4aee25f4075d"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1675-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "25eb075822b8b4c07a7a95de760ffa519d114a0364fa283216b4777f9e8261e4"
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
