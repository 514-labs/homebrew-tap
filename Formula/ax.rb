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
  version "0.5.1727-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1727-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "c02c8ac30aa4c72bd9cc085f5b373b76eeb49170374916a7a034be9eac9525bd"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1727-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "bcda66dc4be032deb544af89adfb6f98078bc2216c033c9b9fdd6e7bfff5e5b5"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1727-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "5e3e5392f84ccc7e8741d0e6c4eb9b4c63fc2c04f8aea220ab40ebe2b1b1d933"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1727-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "a05343e49af4cf401d09710442ec38faf45eaff6ca1c02003e8719a1dfa0e8ac"
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
