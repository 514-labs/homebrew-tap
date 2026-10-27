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
  version "0.5.1505-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1505-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "401a1638d06b0043072365661c3cb3ad040f2ca4303f93470e19937c949cd646"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1505-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "34d39f1980817f4af1cbfb19b7eeb2b8002d4be4de66c33365f4e8506be76ae1"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1505-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "6fe0b5d858b1d804630caeed0af687259fd284251b6dd88f8cb0f09b78df9d7d"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1505-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "d85695510cd361ad7d6d832d13aef3a2aaac64eb76d2adf0e59862f36f16e128"
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
