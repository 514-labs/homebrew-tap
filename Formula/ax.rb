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
  version "0.5.1753-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1753-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "9173dc13b4393fac814d8c57b57f2f97a491fa5870eac5ae565457dad9830fa4"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1753-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "2b174b29140b988225f8331a1641907bdff5e6ff8b411ad7f5675eb0f3cfe689"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1753-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "4c8598394638c43ae535ab306673d7ca1195fb1ecf624ba31890afb8ffdb01fd"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1753-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "e07a1f71726d221a5f8e5e06dbc1562dd9c689d9dee97c6e448c0e5901a5ba0e"
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
