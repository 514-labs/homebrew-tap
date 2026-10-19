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
  version "0.5.1421-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1421-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "c49d125f7051f8ff8e1789dd0f631304bd416dba965640a55e630faaa72cc614"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1421-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "f9a3d0fb31e000f416c12bf319dd06bd0280081728826b6236417873d9f298ef"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1421-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "1535612e0492cb378079eb7fc49fb6099d507376db9a276e5871a8a86b72e04a"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1421-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "af45e907615b2c485d9f79657206ec4ac85947448c6eb45836623eacd32cba7e"
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
