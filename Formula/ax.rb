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
  version "0.5.1499-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1499-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "bdb9bf4e47b1c3f76bbdfbc38703bac691496308b7abceae522f889604724396"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1499-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "d45d372224a86267eae3d45761c9979356f249378e5db810f2ad2135fb7f47f8"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1499-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "e9132e530a20ed2359413fadf6d8c02d0c828c1bedda8fe8bfa5595a743db976"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1499-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "948d10d7210cda2dcd5d0e98ea1d251d2764f3d3f8dd2fd00b2f7e31ebfa9a85"
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
