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
  version "0.5.1390-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1390-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "f668b8ccebed316a232f926d6da6a7aa4e72d72588951e932ec96ba3f5317b64"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1390-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "359a54e8fd1b907f4b447ae3a1db92ce08787ad69e69ae1af4794b4498c9d582"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1390-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "5dcf407f2f7f5124a87269555e3c73ca2972c55f24eac5052280fe1f553f7db1"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1390-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "bfbe8d581d7d12212c5a4dd3ad4ec98e0417749eabaa82dac2cab2906da2e674"
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
