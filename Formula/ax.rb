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
  version "0.5.1641-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1641-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "a1bceb9cc03ba072303a604aea5f98d85658ea0cd6fa970025700d4361c39bed"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1641-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "a783e6534bc2081000387ac4d50018ad04d2e20361b55c9c8da327d4b2b65654"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1641-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "c0503b04c8d0254378af7854c7bc641346f0a695ff1aefa1cf316e11507517d2"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1641-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "fe61a1adc19c4f2e61ae2604d4fc571c1b0be9930e1418ed56423dd5aadb1184"
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
