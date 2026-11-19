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
  version "0.5.1761-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1761-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "e74fab0c9b61041356ea8e699581ab7b59b41b640d3c4a0193a6b46a9f4607ed"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1761-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "bad76ba01f2292b61e6581a3d5c1b6eeba00a679b5073af494eca820e5fc50b6"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1761-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "0862ad6b03db40227e85e13a3b0dbd1dbc2a801fcb4c98c7928d82fa25074108"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1761-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "d355f8f09eb53f930988ed835ffbcef0750361f2e2048df0667a3f456f224840"
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
