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
  version "0.5.1289-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1289-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "c801cdcb4d02314543b705e74e58955e7008872e6fe458159198c5cddc2f092f"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1289-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "1a33d192ffa8407e4ea6b686bddde9a64fc3512ac4c82a96ee73fbfcbc7b86bc"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1289-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "d4d9a3b5fc1cbc2f9f6c10000ec16a0bdfd88ddcc0f8495394ca96ba935f0a03"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1289-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "ec06687c4389ed6a6a90b637e9dd92a94521e8c593d64cedd9cb98a2a9cd4c4e"
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
