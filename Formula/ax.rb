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
  version "0.5.1389-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1389-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "de69caeb3ae2a2494126ccfc0d581422481c795a2d83ab389c3cea55311d7afd"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1389-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "b38d82671ed9b6b61357c942cb255c6620cf925bf80576dbaf10c017f996804b"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1389-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "59dde4c47d4322d41ed124ba30f37d8ab554dbc45e5190defa89a25dc6d64af8"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1389-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "2d1e85b7c4563c7ad2e9b1df442f9ff4fd3114d2e6d893cfe85bd311ad85aa47"
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
