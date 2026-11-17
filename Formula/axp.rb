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
  version "0.5.1740-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1740-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "03faba6f2e5d7ada69c6e24bb563d349df7a7918e6484d8a577e313961f82901"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1740-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "ea4ad01c0a00d00760a81b93888cfc1a1d79e4f0b216d4ae876b0d4e18072dd0"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1740-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "48ffb9e09a2d0aaa4895dc79cc192cd1a1a8faa74667427c4f26056d4245fa8b"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1740-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "38be6e36f2eaad28761276965350edf320c2004fefefcd7c3aa395f7f0bd00cb"
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
