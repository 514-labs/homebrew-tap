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
  version "0.5.1249-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1249-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "2d8d582cae27de5cfdf274cfe0542931637645b26f3cf8fcfead9bb933058cbc"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1249-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "b9c97ee11f5d3e48a6d6f7a12aad20e05df5f9ab5a57310e0f60abcf952c4715"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1249-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "b5b2f048b3c5cd269cc005a599e5071be8f39e94b4630a49e495f3b264d48994"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1249-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "8dcbba94577207752592ae731d617803d6fcb9c73bbc4ede58a41820fbe74c77"
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
