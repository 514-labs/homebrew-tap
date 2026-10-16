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
  version "0.5.1390-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1390-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "61c6f5049d08ef25524e2a1c44d25555e6fbff619aa01f5ab78d8c774fb52325"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1390-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "68750462a36d348445b92275c47a94c8b82d440f6b22dc6bc5569837301c0564"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1390-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "a533b7e45bffb15308bdb18339298edd9fc6866dc86badffd4e95eb1a1baef93"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1390-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "16eb05036639ebd20994b1ee6297fe96e797a482c36ca20104db79f4309c7850"
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
