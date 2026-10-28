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
  version "0.5.1524-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1524-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "ac6332710cc8d89808a6b22a28d151b8a6168eaf386a449d6cb6ed41cce0f382"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1524-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "b06859a3a86f73a1bfb6a8f6461a18ee1071015d437916fc2608bee94e00e7f9"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1524-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "b62c7b9814b0487aa211b9e2085d71b5e0bf7717a1f94cf061fc49310346d920"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1524-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "91804a11d80890093ea8d154a3bbd7bae35d34f3e5c383088c563ddcfeed4ecb"
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
