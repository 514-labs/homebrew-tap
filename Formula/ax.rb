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
  version "0.5.1720-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1720-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "fcf133091ea8b1f3d09d9990624048248d25c17783eeefe5a38e1739dba09cda"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1720-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "40e820b40fb9d11bdc133e9693016fcdb10ea56dabdd6e2df84cd3b91c008131"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1720-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "7ab85d4ea663a6c199edd57cd366db725419d2da178aea8fad8a9fc9f2ee510f"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1720-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "70fb49d8027d6daec6ae32aa31abd51f819e2446132481bc088cdb84578b92b5"
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
