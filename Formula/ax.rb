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
  version "0.5.1349-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1349-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "394e33ea30a943bcfee7e10f73f17fd21320685fbe4eb1be86c0af79c26ccd0d"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1349-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "d2c550b55eeca10dd31c35bffaeeb9f5ae66dc5d6e8b1bfbc26541de8f1d87d1"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1349-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "5afd800b65c37daeede41930f04f15ef02c57db59d2080d98ac70dbe5ed33e26"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1349-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "19837b7b495e8da985e3931372efeaeb3b31ff711b469c4366daf74018bdeb1b"
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
