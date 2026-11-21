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
  version "0.5.1776-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1776-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "ccc069f02cb38fc4a197a06caae897703579725b0e020144a1af697749bab276"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1776-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "7f9afd6a23cd1f34ebbf64b426e4599f1a2bf83e01a71f2c6856ac471d445924"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1776-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "2b4a4523b00eb7d68bcdb7fd944f5e1204f01b65f14b2a45e0166066a6f36b33"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1776-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "e9fd39859eacc8fac458c66a28ff050f3c226da706942644c36d0765b67e9176"
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
