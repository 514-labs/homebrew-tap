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
  version "0.5.1355-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1355-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "2367fe50dc913b7ad91303419ed68c3a0bf281c4eeb33e8b6c8e5b070a62195a"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1355-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "4a31c1b7f6d405b3d595f505a459d1e87a4b1b2eaceb86db88b710adbd8793c8"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1355-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "d5c13c28251649ec3b2d514dc00377c3dff166044d3071d66be1b6027a4c1fb3"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1355-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "66c6b40df2935a2f3d307ce4c2049ea8fe61b36e5a6134537c91919106bed9df"
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
