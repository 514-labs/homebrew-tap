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
  version "0.5.1637-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1637-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "af4fb901619f85367556f217d5135b117914c296f22c32ec78c94a63512d776b"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1637-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "7692639fdc6cd6c3bda1b3b160ff697813f1a61d32a3fc7c3499f5c5984ffb41"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1637-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "ae758fbcc880fac6b5cbc485f097e33d8291af24ee623a9c328a101de32ede2d"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1637-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "1e0f9a6b23ad52b8ebdfe7c87e40a02a171a408247beab5f8b9fbafd9cf020d7"
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
