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
  version "0.5.1253-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1253-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "80eb4d94f962dd8e6e690f0152be4026ee5d5adaef3837b1a3fb46b22ee17906"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1253-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "36216d96ff57de0f753f12c815613905a401920fbb40a64de8586826cc241b2e"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1253-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "e9a6c7f4de3883447f8ed374dbb697aa000047dd9e04a7e7f9eb616506be7a1f"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1253-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "3fa49c284c3bd3f20816705b09008cc3c3199d0dd75ad01e40918e321a6b24f3"
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
