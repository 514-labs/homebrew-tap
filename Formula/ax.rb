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
  version "0.5.1373-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1373-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "88ac1d37115c63082b83a6602f01eda05049cc54f82f1fe85bbceda5acf1f233"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1373-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "eaba177c69bd5d78393d50e702d9f265b83b76dd91ee0b8cd10267144f2acf89"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1373-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "5d8d811a006ab8df312416d529d9ff73676a3c20e6b992be6347a02e152980a0"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1373-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "e8171aa60b0b86ded68c4d5e3d2c02cdc8a32992eddd3597bb6e1a881277ed0e"
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
