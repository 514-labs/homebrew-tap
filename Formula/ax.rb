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
  version "0.5.1442-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1442-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "f0f04fd3b2fb7d5982e22b2cbab2212ac8ebaca1412d97df84049d4f59ccf6db"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1442-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "5d5463fd8a04146b6503833fdd68815dbf8e9bebd38cf715937616158be3b053"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1442-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "9852af7037df6eef01c62a4b0ca010f693469aeb9fdabd5b6e7d01c787d40208"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1442-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "46ad74a7fd357f41772c8864730578a78262a7b4594e8e079e43d2389756f1fa"
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
