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
  version "0.5.1236-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1236-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "13a0ec5b6f5bc09330748583b8e8a1d612bf284399d2cba4b78db6130791a556"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1236-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "1cfd061b0c99ab940b96be8638d3156a9ecf2c9a7597fd7f95742bfdc304d5ba"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1236-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "ba347dbe9f9062a869f3d1f213c36550544b593bf610e9a2ee05c61d1f306327"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1236-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "05bf6980b449bdcaf99595a20732c3f3b7060e3418cb577fabdf2eb64d5ff43f"
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
