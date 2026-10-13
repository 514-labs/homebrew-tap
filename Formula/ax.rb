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
  version "0.5.1341-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1341-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "9636f66a4f057d60a5f5efd9a12214071027f3d4f75aac9c5dcba910a0b55f6e"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1341-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "41c2a6e5b9501b1842b5a4229323801481e84ebf606bd8ae6cfbe268d750673d"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1341-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "03bea57208f6d1fa20f3895e881ee655caf187e3e1ba3227bfbe862913e603ce"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1341-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "d3ca02e5551f9114b182f8e380b578f1c494b8f5b365171c7f2981f2aac11fbe"
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
