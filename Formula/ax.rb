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
  version "0.5.1682-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1682-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "4172b4c59cd13a131c5f8bf4f95c950dfa7f37ce8366697199957f41ae1925dc"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1682-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "5f676a9ba3067f23c8891e0223429cc6342da892d33aa81a801459799d9e30f3"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1682-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "a35aa3a7c36570c1202371b92b0fbe8a0d35ff6bed3b1465921c164b2bcbf783"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1682-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "821b9370dfd67aacd8d24dcadd4be5507347d177de81ba1d5ac6d3bf556bf4a9"
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
