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
  version "0.5.1426-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1426-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "5d60a26817b44c14645633bd148de8bd4f8ec7518f14aac8bca5f55fe5e49025"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1426-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "dc834d44036aa9a2b29950a5b6454604c0e134fa56f8188296b04dabea2100e4"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1426-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "533dd762735a55aba51363c00e8774142cafc8783bd6c6277c8374d7a2288434"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1426-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "7fe857e9622b031c5fa5f2c665d4a428c1ee95599d8b3939e92e2dfd622b7441"
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
