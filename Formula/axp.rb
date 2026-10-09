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
  version "0.5.1307-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1307-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "41b596b8fb66f016c22ccc6653e3cf842ce3fd2c977efb380a92b7216d87ffae"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1307-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "e7677e79dfbd718823449bac95bb493ad4a9c00ad19173d76d5e5ff7f36f5785"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1307-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "109d5bba5bf9a08f8ee178c60725b2a94cc479e98a9be087b6088dbc5eaf4592"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1307-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "0033e65783100e8ea1f47b2966c7a6dfa2cbc667bdefed388ed667341d676c09"
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
