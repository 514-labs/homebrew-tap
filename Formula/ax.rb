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
  version "0.5.1365-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1365-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "62ee0d3f5e3a1ff823c2a00f34e44cfdb58f657f11120b1d584bd6ed01a74044"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1365-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "fec5c360d43cf57d6b8e540ef0bb9ff8683fdd1e252b3e13293360c4f542a7b2"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1365-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "bd5430c9a9eb691972c8972bad132e13251f1205805ebd9516f1b3adb4c60383"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1365-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "dd5414ff83b5565a98ba06ec4efa01e82288b7ec85d016d7ef93af89b40a44e6"
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
