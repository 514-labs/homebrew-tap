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
  version "0.5.1659-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1659-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "bb767006d7e54f861ca53921930148cc079b5c8db107616fb16404d8c3fc05ed"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1659-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "323580c024418fbcfe553e9a3b6bdc182d98b8b498541dbc34716ce67ae7cc0b"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1659-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "12224348ed8ee74c48ba9beb4d322121bdad8f810da5db85bb134a64bd32ca28"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1659-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "e9b940c51f5bdf2dd7fef3f412edb9c4eb91834d7acecf58bce8673f05bdbd57"
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
