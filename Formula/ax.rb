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
  version "0.5.1423-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1423-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "42266ab8ac3853517d6757991db966cff0bcaaadaa33cb39741358a28ce2e371"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1423-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "cd27779da5f8f2466884ad9e948fd45c31b50f539f40b758037d470bdc3303ca"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1423-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "aea88634c737472274e741472e4189a072aae5be9e10331b07209f66c815bc0c"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1423-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "1b8b473c1e2e48d26e96dc3e9e84248868e26c24365c6714e8cea9c16c6049f0"
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
