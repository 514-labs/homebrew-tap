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
  version "0.5.1376-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1376-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "dbe7e6b194c17393b9c4c7d8a3ffe50c067133d6c224dd8669f1de3c7cf4281d"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1376-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "4bab3e77e9a427a4549ad6c8a2f781556e4132672fbf019b66d4f4df8b25e42e"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1376-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "fe8abf867b53c62eec4ebf68e9d88833ba14fe99689e93bced537c02c0dc6906"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1376-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "c7f91106196273e18d7936b09c5ea0f47d441a3238476073e90e48012bbf9c2f"
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
