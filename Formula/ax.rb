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
  version "0.5.1381-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1381-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "bad57be3688229c8fad11a86d1205084291fcb66b4209569e83fbcf1e8c326df"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1381-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "64c727a3ecbc376ac01473226dda04d7c9f85a9d456403b0cbcaee4276bdcdf7"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1381-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "f687db904cb8a076133e9df5b272f135f9c641ee3fbca356411002f6ede5785d"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1381-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "0baec4d3080dd42cf7719489bd526f020fd72bce1fb674ce4bbd74e443072c3f"
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
