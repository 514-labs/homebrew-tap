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
  version "0.5.1652-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1652-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "e26d21e60b7119c69c2987760834d78041c2fd95a0af7f4790c450a16cf13eb2"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1652-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "f3692fab39094cfa82fbe9d87519f47c9077ff2be82cbcde9917235d7c41ea0f"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1652-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "e8b306851a10e72ac3984f10b0557e63534503bd324cfb67e91f6f6420bcbc11"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1652-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "36ba416eef2d54ca6773fa50fcc2f849fd389b6e2f5e6466af3734932ba2cac0"
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
