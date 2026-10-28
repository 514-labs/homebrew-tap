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
  version "0.5.1532-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1532-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "7e90a21f408b632e00786121cb71668ac819453f5a6b06f603842d458ca41f4a"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1532-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "c55bc3adb379870a4836edd848a7eb453212af80e8a7c7c8c8a7e1cf26afb0a7"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1532-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "a92776ab48b0ae582b0fc8b242df94f37045f9355709ba7b5cb0c5da44a4c7b5"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1532-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "46a3560ed2616f9a2e518a117eee9981f62664d8c4deb3a2357a1963b28a7fbd"
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
