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
  version "0.5.1510-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1510-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "56544102bf6d16ffef82e6dd12e3313f8862672aec50c0befa46fa685cf06736"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1510-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "6fcfeb163dff634662545af148392694bd46c9fbbd6799609f5b5f2aaa10c7af"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1510-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "e5115bc4bc4e4b267773829a8caa630dea2605e117d8819a80c31d5d1c923c4b"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1510-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "77421d0c85c09728c568db879272f645902592c8d681b29f30f0c770c3528ce7"
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
