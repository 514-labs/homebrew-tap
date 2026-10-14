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
  version "0.5.1348-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1348-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "22d81c7051f52a292142d80ce17249b34e9a81e0a4f12e06854b08f61103c9ae"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1348-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "a37946473dabc9c5533916efc4d8748358841bd96b66743738b5679357776daa"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1348-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "21feb006814cd0a00173b6cfb7ee389bd7fcf64c78880c1c77976caf12b43cc6"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1348-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "10eeaa00c0baf73eb9bf5ad87990aa786c67aed487b5362d9906b2b6701238df"
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
