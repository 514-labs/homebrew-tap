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
  version "0.5.1245-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1245-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "7b1362b4397442224c4a6bad798a2e1455103a2138967d74e9beb6be9e70c562"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1245-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "5e84220f375c13df84e40ebfe40c4bcbc2e01ffcda24fec0b031f4c7cae866ba"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1245-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "3f927150fa1a63c0bf590fc3d52f22e28f1cee8f25c27545fab338c4486dd983"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1245-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "64128ff77943f384a38c46fb01d891af5f15e74b20ce100d0fa07450dc4112ac"
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
