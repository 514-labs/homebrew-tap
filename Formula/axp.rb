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
  version "0.5.1466-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1466-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "c26b0cf47912e818a0c5d9ead11dd8013f1b067d12b2f899c4a0c06b081b5394"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1466-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "1ee8a68760f3231538bda303201751079f765520a24caedad0d9bd1b33acfbf5"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1466-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "3d95dece850377cf07b9ab8736f5b657d96c0d71b2368a29eb934effe78a1352"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1466-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "a119730b89a24cfc5817e1ee0e28ce0b4f4fd856bda824dcef81786270570c32"
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
