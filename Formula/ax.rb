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
  version "0.5.1295-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1295-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "79b683073fa71374fab51d512abf48408cd9e974c498b5e1d3e3554ee1d4583d"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1295-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "83a4f7b3c6345d4e320fa1e492037b8fb6c1c4742684f93cc0861462087bf00f"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1295-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "c44d1fcbff1369fb9a110b33313a025d521625e0557bfba2545a6362b77c8d0a"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1295-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "b44994c66844b3de8583e30c805f5a820836a0ec3a70b3521fbc03444c3bc2e0"
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
