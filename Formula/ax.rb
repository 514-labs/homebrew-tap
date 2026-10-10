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
  version "0.5.1314-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1314-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "2ab35c9ba84ef66b1ccf56d2aaf231cfaeb611fd45916ddde8302fe276411791"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1314-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "07a741e96c3224f8fbe62c88d548c3cd8b0d4942f03e16367458c66d569eacb8"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1314-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "1dc78555c32d5c9282fef13bb497571744a5688928902cd3486d7a45023da4c9"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1314-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "11206876f4c4f2b64c543d9afc7fc8c8dc87720f8ab94e242ccaa2f358c16bfa"
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
