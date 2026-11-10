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
  version "0.5.1714-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1714-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "91fd999907772cf86a75ddda7c682246c40a89b8f9c462a95fa9f266604b01c6"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1714-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "077c1b027074fdf23ddc6e6c97898a4064342796f210b4c9d5b24188775170ea"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1714-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "21147d83f7af351c80b7056a1b48566f5c04bfef2889b34ecfe7040d279ef846"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1714-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "1bce7586b3a24a84305a43fb8ddac7afcb1d9812b235889da624a7d76d1575f1"
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
