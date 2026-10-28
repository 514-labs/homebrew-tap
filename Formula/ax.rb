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
  version "0.5.1514-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1514-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "c4b5b836076e4e99fa69bcbecdeb5f89f21d34862c724317148ab890da07a9eb"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1514-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "67faca7c866cd3b60025b5164f5523e5ccec41e979b8707a0efdebdaae5a0b27"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1514-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "6416e9d5f17f5796fad7a223c4b94776330e37fe44a8556d56ec64cf15918c6a"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1514-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "c0f2242a0d6cd373080d3567164e21704c3a1a3ba0d2243ff943942f2f4ebbe3"
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
