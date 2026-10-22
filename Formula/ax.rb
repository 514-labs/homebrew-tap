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
  version "0.5.1453-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1453-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "61b27a40468c1166c310ae3fa955ec51d6407f016d209cbe94c9a12c3fce1a74"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1453-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "a42aec8e98dc8d3b1159debbc1fd8209d93d57c44dbb0e15e32e4707266dc8c3"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1453-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "a8b75a05ad89630d3345c339052a57c05af3ad61b4f4e981a531b37844422e79"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1453-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "d2428b61997c572d4676c2c40bccc33812a9f641d8e4f89e7bd8392b6cad0a7e"
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
