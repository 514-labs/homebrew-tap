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
  version "0.5.1757-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1757-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "508fc75fd2a14e57ae3602de27dac8dd75d3da4c0d97684a2b492d70a622dfc6"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1757-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "f8e5fdb8ed64f36959b5241841c5d064ffadf5c72f956c5e2300f395706d4e52"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1757-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "3478b0f4d6786e61057a4560f82f43c07f63a006f156cd7240045afea8dd5065"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1757-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "a56f7c531523276996767250a716e874474d00508665ee40df24651e958b2960"
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
