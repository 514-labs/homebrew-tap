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
  version "0.5.1542-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1542-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "6614e12bfddbe1a0f52310bf50a7ec3362346cbc612c21fbc22d8e95dd4b2e6b"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1542-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "8e342e66db7d0b690b4c7f3ac927384ceaf54d3a5a55f931af74d7c294d79900"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1542-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "68f8d6dac20f41aa8cd043eccc831109c6f1c0954ca86db7bcc86a4363a2b210"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1542-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "2a478f226dd0ad81324a4f43cf87520944bb38f4136f8788d41db4b6ed4398cd"
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
