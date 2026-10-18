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
  version "0.5.1412-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1412-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "0f27359e39a5b3ca068258d1e6095b60a9d0b24c1ec89b8e70215a00e66fee65"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1412-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "5eff3d4a920de4b8724bb2941716314f9d4171926bac4cb5b97a808e87c69a2d"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1412-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "af2450a82f331fa0dec7e23abccc1f6f8e6c4195c3a427427704c8a7daef1add"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1412-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "ff5d3edbd2b058f32f5cb13ad718a1c13a467cf0b737d651e6bc1b7977c573ce"
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
