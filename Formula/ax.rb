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
  version "0.5.1805-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1805-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "2acca154036cfa4145f053c41a2cc94412fe1c7f3a13599fc534427c7f010f14"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1805-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "d508620f2c4bd10b6aa195683e9e9743bb177d08250d5d2174d8c9f0c0012017"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1805-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "492d0bccd27f1f14e24946fd584b09540a3f9c0fadadb1216fb56eba7fac68ed"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1805-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "b195ac80033ae51275092d364388ad4aee712910bab262ff771fa7d2789efa09"
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
