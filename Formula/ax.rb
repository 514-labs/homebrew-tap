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
  version "0.5.1734-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1734-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "d714597a750601a4b88a52cfd4170ff13d814bbd4c339e79e0e963bd0a0c4ba7"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1734-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "92a514cacf45b790406983575e06dae8825eeb55a21a37fde78045316b5df0b7"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1734-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "d50de0de01653b3419479a3480f995093e0bcb7d5f6f115987a17d28915156af"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1734-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "3469230f7bb2398fdd086ddbdeffb4b47af907b723de4d978647d74f3b42783c"
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
