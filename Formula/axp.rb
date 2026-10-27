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
  version "0.5.1502-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1502-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "46677437def8e2524cdd46c552a64ee17f02c68b69fc190d3cab0a699fcb4516"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1502-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "99ae25475da7648412bb4c122a8964066760ddf4ed50db440d4ccb3d4c2c428d"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1502-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "ad2d2299acdbe45a415fa12852bc8cf6f2a52a6a5ee4361b2f58e77ea8db63f9"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1502-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "e9d08688db8835341f1ab9ec2a5c9b2230c952dd5c953bfbea7533bcf93f8196"
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
