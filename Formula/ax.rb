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
  version "0.5.1749-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1749-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "d9fd7fdffaccbeac93936d0ff308faf9fa60b845091e3e152826f18a76a2f993"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1749-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "d642472b7fe61b50a41603b4f38c1c36a247f63ecca8560c768eb75ef03f0e64"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1749-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "8a79ce871d2a197698f1c7b5c00d83c306bb6eba0ace6fe93fd66d0db0e5b02a"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1749-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "6028808214805b511b0a7058afe13a95db36e04eeb5b0cbe54052343bfa94437"
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
