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
  version "0.5.1420-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1420-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "c4d4ee1b8c8c14e1f5d8c09d0d6aac813ffd2f15e19988597cf310d5a6a24ba9"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1420-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "b84d838882c83c8f78b488f2ac545411afd90a79acb8eb1ce45efbe492f1e865"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1420-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "690798446f09f78ad90e4766ff3a5eab61f1ab8f832e3539c688e25fbadc925b"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1420-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "581ad45ac3d6c992272e611770f2bc257df0345d257a0ddbd2c0771b8f88e7f7"
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
