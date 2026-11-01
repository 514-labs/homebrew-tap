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
  version "0.5.1607-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1607-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "56968e2a069c3dfd1a27d737350e786cb55b69d17bc4a37be65a38ab2904b7f0"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1607-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "35af910d650bfb0ddfd2a321cf07d0fb163daa28080d19a21815b739343c25f0"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1607-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "0d754a4ed6217bc04879df4cee602771ba7c0bff351826398658a8e936d511d3"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1607-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "3b1397c61ed7473e16580132e0c9c86bf66b902d3b23048a1935eb48ff7dfcf3"
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
