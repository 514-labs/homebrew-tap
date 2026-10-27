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
  version "0.5.1504-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1504-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "98242be325bfd32e09734d90462d44ae3a7dda5ecbbaf0c76a702135c45e0c56"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1504-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "e305e22eeed5175b5e18cb44ecc2e256473900da13ae857857cda0afcc999ba3"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1504-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "435ad89cbc58c55425eeac3aa8ad514d5da6b26b9cc459fef9ef86c8f329360b"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1504-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "dced0b4aa00591fd27b585e1af31018499e49bd034fd0c3435c9d4cb589f90b0"
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
