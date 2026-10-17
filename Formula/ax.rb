# typed: false
# frozen_string_literal: true

# AUTO-GENERATED — do not edit by hand.
#
# Regenerated on every stable `ax` CLI release by the `publish-homebrew`
# job in 514-labs/axp's .github/workflows/release-cli.yml, via
# tooling/scripts/render-homebrew-formula.mjs. Hand edits are overwritten on
# the next release; change the generator instead.
class Ax < Formula
  desc "CLI for the 514 agent-experience platform"
  homepage "https://514.ax"
  version "0.5.1409-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1409-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "2af62beca1710aa76077ef7d88b13874eff5c80fd046e63b284016b1d64d4006"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1409-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "920f730c3fb5f8db2c5cec3838081654e9c0d2211e6cffb0690d1a694e665836"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1409-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "d66dee0c3fa8ca6554057da172e1ccb8341428b8cd30bcbcad4d4a81b63e77ea"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1409-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "1c0a4a0aecff5f36323d237df7ac2a0797001ffefd639748bdc3e32d266bd463"
    end
  end

  def install
    # brew fetched (and sha256-verified) the per-arch archive
    # (`ax.tar.gz`), whose only member is the `ax` executable.
    bin.install "ax"
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
    # Keep the smoke test hermetic — `ax --version` otherwise pings the
    # update channel, which brew's test sandbox should not depend on.
    ENV["AXP_NO_UPDATE_CHECK"] = "1"
    assert_match version.to_s, shell_output("#{bin}/ax --version")
  end
end
