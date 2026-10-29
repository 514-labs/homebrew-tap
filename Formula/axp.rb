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
  version "0.5.1536-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1536-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "7ef49d8239c0b957049380afa3265e199e6643b00667317e0a6715f194196438"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1536-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "e7bea4ad51147a802f5c4f5173f2da1f03c20eb808c5908819fcc52dceb99435"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1536-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "348a1933e327bb78cf3aab7f6925773357292a7a64fa924377960fde5b02d0de"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1536-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "0d3712a869d41e118bf5840f13e484817a228b682a8e7696360bc9d4726e268a"
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
