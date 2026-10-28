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
  version "0.5.1523-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1523-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "957dbb2e4b2ef648ca25add4cc17785dc69ebd8897780cf6ca9499fe0fa95293"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1523-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "4d9c58ec2aacc5f49c274988c36403252e789930e63435d9aa2a114c474a0bf9"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1523-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "92faf70f7afd8283fa70895e9b06e33126b8710d130ac7ada72d660117285594"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1523-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "e83edd0fb50b826e9d6d4fb0a2a2d1889c67c778af915d835d57c998bde19e7f"
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
