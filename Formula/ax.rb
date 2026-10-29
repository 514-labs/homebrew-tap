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
  version "0.5.1540-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1540-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "0c123ef5616ed576a647c85e51d160be8ccd2602b56a9338766ce960bea1d66b"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1540-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "38fc494dae13502ffa86f3e4ede41dd27d9a2e6cfabf53a222be5627bd04be7a"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1540-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "3035f1d5195ac442f46592a831f8718df666fcc857b54bc4d97a9d1b61f7d3a6"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1540-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "bf5f8b265827f9b5752bdb5feaaaf7669e48de5f2951920ee42a8a46aea82897"
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
