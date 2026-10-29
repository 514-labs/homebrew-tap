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
  version "0.5.1537-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1537-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "3a0c8c4ee1ef690a8432ab6222d7c7200cac56ff15f7b9c85acacd06d561820b"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1537-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "934b72b6cbe419e9b9e5865c6d4c0f40681c1b1a44682cbf6f3ec74fd7020d82"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1537-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "b5bfc5f72f68a5f0348551a3ca4ca09e5faa7e5f2a255b28c8646c2bb97a6d06"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1537-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "d20dfc75e00e91a526765ac2392b6f962af47151eeeec197740ffaef48d48c28"
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
