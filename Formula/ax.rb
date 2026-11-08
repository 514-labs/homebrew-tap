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
  version "0.5.1688-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1688-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "5228b2f1c0bd81b46cc44d6ea1e225c9ad57065db8aa3b01275d10fed35e0b3b"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1688-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "d8534ccfbb6a8a2654aeebe0ac640348c3229281cfa0bcf058244156dd2e0bcc"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1688-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "728079fa058404c0eea85525affce53df1e68531d747346a0dc1825175b7c44b"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1688-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "0b4e3a5cd357644440dc49cc89fa68200a679c9dd57fba3b06e906b55029643f"
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
