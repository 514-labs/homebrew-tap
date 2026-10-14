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
  version "0.5.1351-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1351-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "c1435afac424f3bb99fa72b8d52397f809f569b78a9f5fc974877fc07575aa9c"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1351-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "4f32ca9ae3dd6a8f31392da38215762543d23b7b2f606c7f083458b65a4304dc"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1351-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "1b1b7b6d4fd78eef8cb1456a9e8f520a6c03a87c747f98baf296dbbaa4188833"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1351-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "72cd373a09c44929ef98c7ac4d7f5e74eab7b83d7a0d324482ef81950dd018d7"
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
