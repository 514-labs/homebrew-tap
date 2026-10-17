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
  version "0.5.1408-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1408-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "de7b79c4603998be819e3c6fb26db7c07447e5fc1e6670d97268febcaad090d8"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1408-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "01e6b77e29a3c89a09ba5ce9331c0464d04b1a6901e080641f7790dd12813878"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1408-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "b0465a73a023e52f47f0182142c1c2bc446b6a19944ab1ec54a81932e361c573"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1408-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "e2e7ae3d6a153119eb7a70b79fe307cd0fbb44e9cbee699da23de25544d8bb68"
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
