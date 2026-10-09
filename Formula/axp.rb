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
  version "0.5.1303-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1303-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "88fd8191e06b36b25d72b3f0f194398b988762f97a038662c61529aea804e44c"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1303-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "fe86ba36a8892db9e14eb204f2eaffb09e0cc97b92f2c0433da9aab2c0afd366"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1303-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "83a1c14a6ffad26599c23437e6a21b0d1d8be45824018cbb41f5c5d357e98175"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1303-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "c3395f95ceca3b49490a715a0608c09677bd62b11cb0b08952cbe0748c41319f"
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
