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
  version "0.5.1439-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1439-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "b251f6ccd1d1e3e400f547e926762eaa0becbbe9978ae6072f7b5eb933d53e8e"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1439-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "1720d9a1d40b515767ba7219bdd3ba87f386ed149a43b63a6ca6b30e3a3be25e"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1439-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "3640c994e9e08d465bc23217b156427fa83e68063c5d7068a9a61e5145cd596c"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1439-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "ecf5115f366e25b00632b4938232b8a8770555cc644e40313462c8b489807e90"
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
