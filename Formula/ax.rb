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
  version "0.5.1541-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1541-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "a10d5d7b516cc89228fea942e0f0ba34acb46f532840badccea270d1f2e22eba"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1541-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "904d9d66f374ef5299c3e9639cd77e173680d2f7ff5522e393be003056e22805"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1541-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "29ff54ef5dfb60b4612fde05775aa970f7965a0f4f3d506af8d4fcc8e09b9b4c"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1541-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "cb65c55238b0e0fae3ca0762a3c5e35b8d0b10bf961df8171f435538ec3e7a87"
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
