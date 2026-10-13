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
  version "0.5.1342-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1342-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "1b350d057f148f80a69ae57f7cd0a69be49c1a1058d06985100fe501b5340339"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1342-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "9009b9dedc6d278d11156a16988a26deda536b41838c3fd4a392f1057bf91679"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1342-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "30aee0a90d6c20fa850dd34f77984605bc29d67db496aa3f0f9e50868f9ef7c4"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1342-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "e5b2e0fe42c0f0fb6d45b0f252d55dfd65f430d282c727d659360a7b0e6088a9"
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
