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
  version "0.5.1519-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1519-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "804e989b8516eb21ffa896a46e19b58fbe17f6217e478cd614a74015a8d53126"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1519-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "ed03bbc2af7a51c22793c63e0dd46311c62f3a470c1982909b49e48d51910d72"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1519-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "2fef16a75b2dfec9cb1632773412089c7766422a789153125110a22c0e3c19da"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1519-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "db5967b73b18a4ba3d8749cb596ba4ea953adf60b02b7da6b23245855cf4f922"
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
