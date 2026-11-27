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
  version "0.5.1797-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1797-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "7d70706ec61e8c1a4efab83ded404b90883050b4a36c5e8839124d51181317ae"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1797-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "708e8fa63b0c91235af1030ccd8488cae17ca7067a29e246f299cbbfd30165bb"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1797-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "005dfd3316d4b8ef91df58feb47735930ef2c3453227fe1b2fdb178fdf8e0a70"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1797-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "ccd512fad3edb7de85316ef23ba1cca776d8f12d1bd2ca3b09d660dd9f064465"
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
