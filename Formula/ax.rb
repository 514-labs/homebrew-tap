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
  version "0.5.1475-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1475-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "3fbfbe65589147d4f743e111437b3e4aab591b8c98c4fe27ca8075c38a870ca9"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1475-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "13eb7e1cbdd89803f1b54a6ede62242b88310a3a314a4bac962d4f60c7aa18b5"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1475-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "a5cb5975db5a82f07c8307ec361b46534bb161964aebc0fe023dcffceed33d50"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1475-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "93a2399e234d78dc904f86e16e68631fcab6f2a04cff1a17a4c62fd782714416"
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
