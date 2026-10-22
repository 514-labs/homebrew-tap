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
  version "0.5.1469-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1469-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "7c87d0a58eb47876bd9981c80a6c13bb15f0281583d4a1ea723782f258d1672b"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1469-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "6c129c16d62f383adfd967ac28792c9b6e782a1376f4663a46d4b9d5131461e6"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1469-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "694648587ce901af3e95ac800886833aed4f5bda5a38ebabb2058df8bd194be8"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1469-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "1fd3e4d038e785798ffadfe38ca50ebb30b1c911c97f54b5d65249dcb28bf0d0"
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
