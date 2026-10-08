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
  version "0.5.1282-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1282-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "8159a83295ef307c6b75016a190f3232710b835da04d5185e1f9bcde7c0a1ca6"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1282-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "4aa4650a7b9c22f918d86bbcaeb971ec4343b11d3dbf03d1a01a30bb8d9b19f9"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1282-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "cbf6556ea9d3f5aa369098c301f8f4e44a062fa8b56facf81792130bf63ccb6e"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1282-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "759e53633e29ca913bcc71725c7219a21bbf83b3af8b32fa1355a6693696d65c"
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
