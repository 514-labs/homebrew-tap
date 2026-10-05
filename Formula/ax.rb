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
  version "0.5.1247-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1247-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "51200946cccb640641305ab6aa1663b9bd63edc89d44bf01bbcc1d4b532a7722"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1247-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "3d69656fb562d5e6bc3c9fa4659d47ed0b878df351787cb02a9e2e24fde3e7ef"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1247-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "9ec1ec5f6c4aa2b936d98f4e46055abf544d5006930a530196b8d249c93daf07"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1247-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "cf3caf7ca9fec873ec83c67b4b378c0deabcb4d92f149c68829f03cfe3b00a66"
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
