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
  version "0.5.1400-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1400-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "20f9bc7192ebe78ab11a97c8fad764c1016628a0e097fb6f236d39bbe46512fd"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1400-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "75991439f2b481f8405f067edd15443a423bdce71f58f414f36afa6f00341ebb"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1400-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "404d6bffe8b65b08739d1520741ef2cdb44007202b94d592646a3a917657609e"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1400-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "94afd8d4ddbeb85373dc4f5732c7bd70a43688d3488e8300e99be817aa5c97ba"
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
