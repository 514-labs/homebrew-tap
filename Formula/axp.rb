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
  version "0.5.1776-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1776-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "3f552d134e00aef1deb0c20a8cd0b17fb1c730369dea3bd2f8fd35b59a6511f1"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1776-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "d08727a7c75c353d23bc87fd0bb80f2d4d27ab029f3de9e685f5e2df9513c7be"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1776-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "396b220d3ad02df7c14ac8bd8db4268e72acc248d1c279c15b92466fc0b6de6e"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1776-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "50cbbd57732d02851caf9fdfbb2a32fbe8943ebe522c0b61141d331a544a38d5"
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
