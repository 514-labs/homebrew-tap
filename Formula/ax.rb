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
  version "0.5.1403-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1403-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "1a69e11171ef400a875c5b122b1d2284d9e290774d5199d5c3c55f8160d88710"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1403-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "ed1ef4cee6620461b486085fbae4e7033abaf067196d3f0b757946d762cdc8ca"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1403-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "7faff3975195bc2e1651bc37da3004049c34b77bc2816d0ecea23eac047bda38"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1403-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "7cdbddcbe4497a542f3a6374df61ea3007ce363ad719f24a5f68303a0e3b1a76"
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
