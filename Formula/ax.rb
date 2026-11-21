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
  version "0.5.1780-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1780-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "746f0e16e711c8e3cd4ecc3409b71b16a00ecc0a9e2c84188f9615d3c4e41882"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1780-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "15f4d7bb6e6a03e6f71c74a4409b8004f880d16aeaff698ecbeca02260bcf91f"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1780-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "713a9738ab7f6f92b996dd4440c35f6bc7a04ad293113a4bf41ef67f68b1885c"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1780-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "e1f2b12fa115023dcd103ccd224c3af09421986fa9f264a77c451cf2920094e7"
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
