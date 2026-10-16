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
  version "0.5.1384-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1384-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "5dfce7f2c6556138d3e9a7356c218e3d8eb9646c38f9ebb3e5a0b21d1aaae455"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1384-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "5f8cfb6b83b9032d451cbbf31929a98e3f9500c3c931eaff2e54ae1da2348d00"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1384-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "048b9b9396407f7c71ddfee3ec5e2551df0359124cd6849977ad1b749285a2d1"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1384-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "040d1c1a38fe07d8b432e3e5ddbfdd0017fc4b4c68b24dec65c59b2853c979f1"
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
