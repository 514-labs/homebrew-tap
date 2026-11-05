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
  version "0.5.1649-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1649-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "cd0463c9c2e8f51ba726e7bd227bbfd177667f8d32c69c498a8c201ea9eda4f9"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1649-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "06f2c5ba7311a54788201bd4beb8de50916da1dd2bb7df2e0f1216181e2ce83e"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1649-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "1b01f34af80d4e24ac9110e2cc8b1fd1643c358fdc652a6d3941ac8c50a5f7ed"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1649-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "f702da2061d52df7696d5faded4407aa41831d52b767a07c213d3ee9f2227246"
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
