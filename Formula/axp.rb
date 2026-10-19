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
  version "0.5.1417-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1417-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "e22696c858051fdd11881f297bb1d9e5a97f47899fa0f54b7e670dd08ea2cfea"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1417-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "bcc27549e22ba27ada5be71c4846e76ecbeee601763ffe59c4a6370aa44efb53"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1417-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "39ec149fd20d5d84d77863a13285acecefd2284e43b462a1370f19ebe9f79b56"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1417-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "a428afda147668c4f7950bc48ab416dca36e90538d8899ff0df3404210469c7f"
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
