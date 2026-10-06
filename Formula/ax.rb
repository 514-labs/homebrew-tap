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
  version "0.5.1252-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1252-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "0fa37db00fc4e371c2c5c16f9aae50c9a0d55f156dad1fcffbe7c527885c0ef5"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1252-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "0ca8883f17342447cedc464f66a0ccddc2266e0212baa40886e686c5fd329195"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1252-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "9033bb3f6f81618500e80a6882fb156b4b78a88e0935aa71f9fe6778c67f2717"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1252-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "97f2e7e3e7926e8b53ad1860a290cf35b00915b73a208b535ae13ef9532f3548"
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
