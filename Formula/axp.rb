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
  version "0.5.1792-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1792-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "a4c584486dfbdabf6b3da12b7f37ff39a2b03a5da4b84ad4b5ffee4d9816824c"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1792-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "907b9328c7c67984e2bdb68add2541f63beb56a309e33cbd5df8cc9fe853820b"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1792-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "4cf8bdcbcf7e44c53597219013d278b80c564a3524214198e88692b727027417"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1792-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "95c31efb6cf542007cfc0fc17888e9de657fb1b62f38898b943d5a0b0c1853f9"
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
