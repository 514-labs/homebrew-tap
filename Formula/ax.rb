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
  version "0.5.1631-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1631-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "bdd1149845ad3c159f77959961a0590dd67b2cb01570ac683f92e9d33f6d4b27"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1631-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "9ea201c7d04bd650eac69157e49f9f7886a30e702cbdc3aed4020cab93b1e3d9"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1631-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "e8f9c0dba71a6fafb4ca27bf6274f5abf5ebbe34c21e481b0c2610cfc0e02b1d"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1631-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "dd01e860cd9c5ad9d2f377acd5b1ee878e0f25d323bb6f0765a01a9ea459d1a7"
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
