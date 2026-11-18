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
  version "0.5.1752-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1752-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "eb785278a8df904622514e2cc31224de447e93012613107dd58d492b6cf50341"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1752-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "f54ac77d4dbf9fb513031cf94c6c954ec19ebd1ceb03261ca1f173bc4ee1faaf"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1752-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "c4ac6e3dea77ec4bf8b2c4e6349efc1c49beee005ef6991a0f671ba7568936f0"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1752-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "7b312e8ea77af1c7e99923890bed840a282a23bf2417ed9e9758281d6b5148de"
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
