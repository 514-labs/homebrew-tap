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
  version "0.5.1426-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1426-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "f626ce80c119defd92ccd683da49cf3d1f83cdcf4f4eb09d02919bd986bd4cbe"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1426-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "ebcbbcc693bfa2e222caa41015c71cfd9a7056083c0c47722077ff3b788ddd90"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1426-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "20fefe6af7bace69e485cd6193071b1dbf8013c925b758c53c47f64f9ccc8c07"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1426-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "c23257a0d50e9515b7ac27231534ceeb247785d3fdb33c091ff14cfb8b1c7649"
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
