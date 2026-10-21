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
  version "0.5.1443-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1443-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "3f75575d3f2e4334496f759089e41138fde9266d7b93031292517d876ad79056"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1443-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "bd2f22b90aa7cfea6e67aab8cdfcdd20dc8330937160485e6924725ec6f04d44"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1443-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "5cb05facfe3a93172328401fb67284aa3948405c273134889c847415939dc4de"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1443-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "857f981ceff3e52e89dcf1c0662ab3ec76d2933fbc492dddf415c2a4910de681"
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
