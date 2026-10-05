# typed: false
# frozen_string_literal: true

# AUTO-GENERATED — do not edit by hand.
#
# Regenerated on every stable `axp` CLI release by the `publish-homebrew`
# job in 514-labs/axp's .github/workflows/release-cli.yml, via
# tooling/scripts/render-homebrew-formula.mjs. Hand edits are overwritten on
# the next release; change the generator instead.
#
# ENG-3612 deprecation window: `axp` is the old name for the `ax` CLI. This
# installs a byte-identical binary that prints a deprecation warning on every
# invocation; switch to `brew install 514-labs/tap/ax`.
class Axp < Formula
  desc "CLI for the 514 agent-experience platform"
  homepage "https://514.ax"
  version "0.5.1247-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1247-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "2abc3f9171f092a02c59fb8a3eba991f32e6ac9a6241b3c837b1d34d1ae56f6e"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1247-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "d1137056c28e963f87f96418330a91901c754b9b02627e5e5f2c60d8931ce135"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1247-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "30bcb67ec6c27f1821ca7eb1c52b6947879774520425a0b20e67c4d5fe92e5df"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1247-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "27709c9f35b7b2afa03bfeecec1db53cd890bc5b9eb30acbeb9746467ebd7e62"
    end
  end

  def install
    # brew fetched (and sha256-verified) the per-arch archive
    # (`axp.tar.gz`), whose only member is the `axp` executable.
    bin.install "axp"
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
    # Keep the smoke test hermetic — `axp --version` otherwise pings the
    # update channel, which brew's test sandbox should not depend on.
    ENV["AXP_NO_UPDATE_CHECK"] = "1"
    assert_match version.to_s, shell_output("#{bin}/axp --version")
  end
end
