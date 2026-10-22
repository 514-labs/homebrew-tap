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
  version "0.5.1447-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1447-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "61235d8749fd56a967f2fee1f477acb37e4bca658553922961bad3981f2ff2c2"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1447-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "8771e9402c9d973ae209c17bd18713bcb16697411f4726ceed4d8fdd9ef8eb21"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1447-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "95e5fb9b863d374a8aa9dd5b53ecc7591b75a44b3e8930139fe624aa54cbffe2"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1447-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "ac29f63c44705e39325befa3ec7a19c14ed9d3cd11d76323652fe218a80c73c1"
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
