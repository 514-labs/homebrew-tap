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
  version "0.5.1458-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1458-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "ef0af4c0d085b421102bcd5e831b7e58c1e7e8e41bc93f982b3b7309d0a6f3bf"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1458-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "ec95c40fe6e6d421200794711f146130981d7d2b981897601093950ede807d25"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1458-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "34d41e601b0672510c12b780daf6b6a15858cd461e09fb42d33cb4d8db7317a8"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1458-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "9d8a26d8a0b3421ebca9aec1c3f8ff3c8ecbb485e75fe24e701ac05da599a023"
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
