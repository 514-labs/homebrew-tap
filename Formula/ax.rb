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
  version "0.5.1536-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1536-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "b1a0d3be2a3c9120b9754fd6e2a2eb1e65d8345426ff2ff70c87fa71cb4b5377"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1536-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "4f2f2f15f60570f0f3a8a406d8f07b3187dae0f358204afb294475d14cd03449"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1536-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "326d5ab6a4d52f7bf727eaacd48880edffe35c0b3366097c12556dc097456951"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1536-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "7481f67836a5f9fd9b0a286a2d5e98b685bbad781d0d92094625f911a47f1010"
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
