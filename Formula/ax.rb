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
  version "0.5.1665-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1665-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "2173d7229eb5de1f618bc51dbf795c375fbb2806026bf85e38aaf703771da010"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1665-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "ab733435f515fa05f3c04cb440477bb442e1a48fec6dceef976406ac77ef66f4"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1665-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "aa4170f4d86a663864ea2d34182dc12746ac85f0ef87062596e5a7480d6a313e"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1665-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "001019404bb76c20839063b5765f7a4b4a17d01a41e00e902b1e8a1f46c47da2"
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
