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
  version "0.5.1343-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1343-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "13fe1297a7b19ed16f69f582c1af0a1261e5b5d5ccdcbc618de3759bcf7d94b3"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1343-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "9abd3d6ddf37e45278767058d5021c6db1284fa3837b0ca5c3ed5ae0066a0e5e"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1343-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "047487320e6642319266fc518d153badf706b1a1ef17f0b32027e97d7224e49e"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1343-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "35dab81c04ab17d23b437a3baeb602c9fcfdfcebe9d2986d333c2aa39dc9eaf9"
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
