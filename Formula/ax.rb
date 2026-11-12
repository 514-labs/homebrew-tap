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
  version "0.5.1721-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1721-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "f19eb461269c4c1a13dfd6e3ceb09d9465ea84ce87db9f3829bd25e3fddeda1d"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1721-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "1ba4a676dc4503a40a074ddff522e925c38dd2a9e6450df371a3cd7347c51e65"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1721-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "9494fae8c0aa89084c83928d1f6c1a70a549f60e6655dc0e272cb7a47899881b"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1721-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "55f105073be5ff1d4f322a660d81e58507032bcd3c6ea7bfdda62cf67334e5ee"
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
