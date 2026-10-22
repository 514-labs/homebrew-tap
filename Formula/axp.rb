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
  version "0.5.1459-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1459-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "dae210a4e8516dd3a91c5f5fd347894b01f79cb4d1d8cfe3b2abcc2d133aa479"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1459-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "303b0e515aaf495b4e76b93c254ec374715ea1027df1d4236052a506ea5615d1"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1459-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "7aed03dadb31fcb8576a83ab653000608d3d53d1386926006a3213b2a240bbc4"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1459-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "5bc9a0eccbb236c6b4e19ee0f51d7f478818edddac86d04616a2e66584987c0a"
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
