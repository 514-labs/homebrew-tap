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
  version "0.5.1742-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1742-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "6246e7d23581177fd63bf9a7393133969db34b643f37413a034dfca32aa58c6d"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1742-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "05b0313e7a59783287cd25f64eba74e869e908b86c51ea5a16b70b454e1a857d"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1742-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "9bfd5f44cb01331c6b5a89659d03f5b13a4ff76685fd49bfccd179da9163aa2d"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1742-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "4b3c6dcda164f3a5b2d23c631f86500f5c0955cfe98386fe14b25459587d1ac4"
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
