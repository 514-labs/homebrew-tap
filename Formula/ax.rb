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
  version "0.5.1663-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1663-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "828a249abe0274067ca8c8b594f6238c821a475bf85142657f580062f7b5d28d"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1663-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "079010deac9888a0be1f34f8ad5c77ede52fda2ec824d1faad9d7d4e70d1e402"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1663-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "b6758ad5ab252e4c45f6002b08b08c8393c3ad0699e836abc7243b60f8c00710"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1663-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "611b86df690a241663fdb6d1d53bdadea9ee2bbce5ee82a235694c037c4a6536"
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
