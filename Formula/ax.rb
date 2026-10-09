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
  version "0.5.1309-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1309-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "2222cbb2abac8a9214561586807d81b1d2e8614b70f66f1503204d7d432e65f5"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1309-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "1a6b61c4d99468749806d33eae916de3972b76ed1859d393903d3aabb76c3369"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1309-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "d351c4381985f36327833a50110da0fe0d60ee5973e7ca86ed5b96317652fd6e"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1309-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "1d9da2f96210a1b7709f8e301b83b8ffa835be91f6cf64d9ad884bea99362a7d"
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
