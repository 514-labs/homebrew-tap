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
  version "0.5.1793-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1793-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "6c17cd99ea132d272ec67cabba98c587b9f72e123bd4f58d1e8bac2004ef18c8"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1793-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "062ccb4b081da02f115992ee1461913e391ff2f5544fde6ab00d04890e5fceee"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1793-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "76e1480518fe22b080d2a67a8fbbd3ce8bea31f7e13227e1e733aded51e31bd2"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1793-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "f3cdfc48d5abf398d2a07de0a9796ccbaeba006024c81234a5512221b19972a5"
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
