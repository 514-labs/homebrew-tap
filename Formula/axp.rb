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
  version "0.5.1392-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1392-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "b0b216eb1ee90e583f88fd155fd27f3fdce04f73b86080a928043d9c40dcd0b0"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1392-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "ed3314ff989cbbe4b5e2276964e7aa1d8f122fb725619cff60a1b05df6642966"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1392-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "e860aefb38dfd402042b6a9306359e266ea5d11d0d32f43ac68d536269528cac"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1392-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "99255bf607aa1214882cc4e17ad640bd3f8e9a285535b7f0dc08046961223e1c"
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
