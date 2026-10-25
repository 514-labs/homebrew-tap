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
  version "0.5.1492-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1492-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "ca3d0b4c9b9630551e9ba7be55d6df450297a5f7923864aed3dee83e39b69ef8"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1492-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "188eacb69cd154da3671d38d66aff514db44492b5088a26f9d23f957a9e8fa64"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1492-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "936a833e8f6af334935ef69b7e5c8f095d3d7da6e941867035dade4abe385480"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1492-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "ea4d8eab7e60a17f0536f08e4be2bae0a627d0e437aa16667571461fc1f6e47e"
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
