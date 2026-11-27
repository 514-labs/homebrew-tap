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
  version "0.5.1796-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1796-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "8ec3af9917d74ad8a93b7983d1d76ce3a8a2ed8f8ade33832e987cbf0680c2a1"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1796-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "ac6a67d2e07aa56e1a7b81a7ad8cec8854520b0a269b75074698307cd4a77d55"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1796-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "3a2d3863a53730bff2243e834de5a133ea991ab4361e7c841c22c5c1ae8eb647"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1796-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "bf78062b470947bb92da82ba2753b44f46f3ce60c95059b3930ba8b7636516b3"
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
