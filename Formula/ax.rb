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
  version "0.5.1495-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1495-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "7227abac7f0cf2a9a121250f492aa6777c4fd1a5ec16c17bc30655b570796a8f"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1495-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "4ebd3fd3830be543015fc0025e85a3f3fd65b638f1ec8755ca4876e70d8cc9ad"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1495-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "30687958edc9fdf951f9c51e40ef88d7a34d5905f018a5273c25347bdc9c901e"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1495-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "07173c904b8d87f542af76702128994ed01e71a256599f1cbacfcc923706d227"
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
