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
  version "0.5.1266-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1266-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "788229ad76b076c6923972e1dad954e963370b4b481393d4da2fb48f7dd7e476"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1266-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "917fa2837d8092b3c9c9a892929339b468140c801e8e8a29eb5b2d25e33d0e77"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1266-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "28ef5d54f020da95da091d921f02d7728d7810ec4b9a3a7ad5ac49d8720f8b0a"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1266-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "7beba8a14a7cf3aa6f16d81d1815fdc615e2bd4c449531c0a1b7565a4d9d1026"
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
