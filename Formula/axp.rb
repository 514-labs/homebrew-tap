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
  version "0.5.1476-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1476-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "89f4a33154922391e780299612495ec3bbd44e941da0067f9b21a7518c114e09"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1476-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "bd16b9945ce4478e15276e0bd3ce5fec376a8edd0473bc36c0e7551bec9a64c6"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1476-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "8e64b1a1a01ef515ef9df627bd00788837ffcd835a6824136f7682db887c8d52"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1476-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "ef72408cbf6eaf8bc36fe5d889b3e8c782d49bdcf08bbb65ce193e079e24e927"
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
