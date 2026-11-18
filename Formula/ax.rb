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
  version "0.5.1744-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1744-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "95ab8cbd19f0133c8efdb72b8806b652f969efbe38e20678fb443f3bd434511e"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1744-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "eb7cf3a8c6e71814fcfd6369813b0fa9d10b573ef5fe797ed48e1517cb51183d"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1744-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "4d743c40a3186ca432f4892c30516ea7bad61774d88aa1e417f27920a38a2f44"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1744-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "f01163d0daf3a0b401407a816186db99001267c25a24b2be4b464ac0a6d4bd03"
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
