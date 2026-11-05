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
  version "0.5.1644-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1644-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "27552d0b751a3e492ccf37cde21311a899ae9a949e9618ea2cb1ff75b6934d66"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1644-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "b43f43ef2e93a9cc8bfbfb06ee9b5c7d8928cc39fee47bfc1c04c8b62c3690c3"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1644-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "4e7b338487430bbd53bfe6fbcb05df05a4512cd93a77ed0957e480d6bfdef26a"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1644-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "07e707723446eb22230b0b1c18fc6edbb98041f36a5760c557bbcfcca8a1a497"
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
