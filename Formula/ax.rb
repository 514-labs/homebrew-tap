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
  version "0.5.1743-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1743-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "c76c43b296e2ab41193831b750f9c66b7628fd94106243bfa7ae4240d9a1b44b"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1743-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "49ab951b7898344775420755b1b927a3c4bd509589a87fe96b0f112680be0f7c"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1743-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "36f7037a0ac41c0664ed92dc457985bdff332d62093384d20e7679d11127f5f8"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1743-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "6cf657ef7f491f5b4abdeea9b2cde37b89a5b5833bda1dd5c0de27b4faf25248"
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
