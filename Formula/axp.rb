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
  version "0.5.1796-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1796-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "8ab5803de484e0cf78fe845fbc49d34a511fb4d34ad43204cb4740e7464a25ae"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1796-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "c4fc42ca07733fb05eb1d519d573c1d3dfe29ec1c540953c1ec70c53ea4ab5ef"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1796-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "77f95194bd7361aa8ce0744a2ee69339190f225061a86906c6e87b23d485ee42"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1796-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "e3a8fdb8c305fbcaa2b878ba4bc7809a12262b452593325edcddd9e156f3fa20"
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
