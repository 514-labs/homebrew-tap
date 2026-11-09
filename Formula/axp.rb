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
  version "0.5.1704-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1704-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "a1bae2b087a702e75612b9438b742c803242ff43ec74bfc9b41982bc35f0563c"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1704-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "ba58b289877c3dc46c2d2a03bea6e4bcaebcec8d96392f301f8ffc751dbcfb34"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1704-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "ffdc10d0857696ac31e64b5ca57e024777bccc9d1c32f087a0d6faebed22c934"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1704-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "fa1aa2c30b71b2d5c8c7c99440f6b4863ffb8276695b170261ad9ebe10638901"
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
