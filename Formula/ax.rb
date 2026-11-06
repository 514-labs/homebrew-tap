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
  version "0.5.1657-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1657-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "041d8c851171fe16fc7f38e22fd7064c469b723da5ec5706974ab91f89558489"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1657-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "5a7a659400eb98449d29c670f3274e14a3b463c576e78ad2ae02b322c81bda85"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1657-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "9ef6b3d0d8a9171f55b7a9e76d24651e14140b3545af03bdf348cfe6811c9cde"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1657-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "a1868918e45aaf75c323fab2d435ee24f29a39352c60be57c12061955520320e"
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
