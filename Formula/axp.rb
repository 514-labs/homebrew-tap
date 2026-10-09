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
  version "0.5.1296-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1296-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "c47b88f71d63d166139c0cf6a7e226c47f4f7ce797570c9c5358a003ffabb971"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1296-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "a0c6a08eb4da84d21cb6590020c3d26745cf2436df7c7c42a449a9cc0fb52f71"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1296-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "7a36441945514c9bb272ccaed9a377c5981b9c48e0d32e607a6760a612d79457"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1296-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "ef5d3a4e813a71684be0cf7a9e48d0df03a9de5e06a2ba5f03711fc7644d3a1c"
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
