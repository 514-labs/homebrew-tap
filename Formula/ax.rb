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
  version "0.5.1512-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1512-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "ede9364c5b8a844145f20c842e6e0b7338e7491c52ca5a8de2ba6f85b12b7f6f"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1512-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "050f2b9c1e46e7e9780668638dec19a0aa5c28cd1fb3b70b8d4d56fc79f5bea5"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1512-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "723ab5bf1a7d611b331ef1c8173960ffbbdefbb4f0fae13cb094f0351ae07c25"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1512-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "c0f519f9aec5d98cabe44e7f766536171110beaf8765f5538e46c1dff4570e33"
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
