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
  version "0.5.1713-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1713-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "3398b9ad0267590c9baec00852519ff6eef04c5f5d5da102c80c50adcb62f457"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1713-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "ed3566554d6010c31ad618f26cbafe07dd01a670ebe25e2cd43e6fde45a4ff57"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1713-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "26eb2b098a8a36d562890fffb535360a7e59f6635fd225190ec1ccbba2b3157e"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1713-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "c5285010cd145736ab7f1587bdcc1f76978fcf1f175909fdb6d4c2f2af22ac75"
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
