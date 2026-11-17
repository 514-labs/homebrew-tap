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
  version "0.5.1740-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1740-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "51465d9604b763ec8da264db969c12b1672f7a7b0f99bf5363ef88e1c5af3eae"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1740-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "eb2829fd3b7cc40fc3455a13f88f8c926d131e8a411c1e7be51d37d5d975deae"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1740-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "e13694f1c86506090dc80d751388c21242690b60de0f90c33f7de8b6931c2429"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1740-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "8515b69d94742fe45c567434f0ae1465645c2d083e2cc4828bd13f26fb1222cb"
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
