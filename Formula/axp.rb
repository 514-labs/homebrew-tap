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
  version "0.5.1320-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1320-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "41ba5d261736effb89811a11c2284c48f881b5c597e98ac42c8eab6d41d5c3f1"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1320-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "dec8688ecf538940beff908ead9cbb4b3bd92f67c14b9500129aaa09754ddffa"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1320-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "d47d78421e30561658345c10f63cedd4c72f341807a086b9594c25744badfc47"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1320-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "824fae38410e1c7a1fa3699e31504dd5be61eefd0acb0e55836feef07147c0af"
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
