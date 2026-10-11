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
  version "0.5.1323-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1323-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "f168bdc94b6b9108c767a617b83709550c5f03bceb14a0f9f7ca989ec0468049"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1323-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "4e79369d16dfc0d397a8d47cd47d2d8883dbf7d6ef12cb84264bab9865ab7965"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1323-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "988050f03336be58e5708a377dde7a533a693ca12bfe9f6dcfe4d6dd4459e5d5"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1323-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "268f6bf658400f6c4546afb50dfcd1cadf28bb8c01bcb77e073a38850292aa1b"
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
