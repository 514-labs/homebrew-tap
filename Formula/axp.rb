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
  version "0.5.1230-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1230-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "cbcf397f9ad62cea82364a0d9b2bcf05b66de25f0b3d9752bad67aa92d7b93c6"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1230-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "5f80a84bc79b1d0186e08467a02e4949aa45303ec88aef25f4d759b173acf709"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1230-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "7d08a3647e567b600e6518456b94d8b65922db34c47919952aadf1f476252e21"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1230-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "12f659fc340c5c1e818188d57135cdce2398ddba371dff1e0f4e6df8747b6325"
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
