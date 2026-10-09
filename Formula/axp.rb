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
  version "0.5.1302-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1302-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "66e7a8229d99b7dac5fb100b20e56abfab27fccef645871c5b6a5fdaed0f927c"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1302-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "904a37c7b512b471b26c98c8ce962e80ab9f93597190c89f8e744c832fdf5222"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1302-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "4b11667c2193c5c2f5f04b8b28a3268ccb046bb73cff082ad51cb3de6b236e91"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1302-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "ed9b02473e7d3850ce3495536ab4e2a8260c937d956682a7350c65e0714b2287"
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
