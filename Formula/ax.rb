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
  version "0.5.1696-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1696-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "cf3799d1db10103193755ab92be8387cdfc4b5d9db597d95a5be6ffd2191fb1e"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1696-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "6e89e22893740b80053c6bc7a22b3a702e883d75fcdc3e3a9452d6cab8b0b70f"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1696-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "22aa46bb3a6e0f773309c8ca0528214a14d5596c2793866ded110cc7525e5fdd"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1696-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "f2234f0a7343553bac1d9f5db2612b4633e6b69404cea36dc6ae5d54555c26de"
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
