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
  version "0.5.1777-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1777-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "98abbde1d70f8b7e3cd6eceb45e023a38edee74dc907e969cc1a5530e2c7ad92"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1777-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "738446f6bc1a2fd885080f24ea8a32b699443d21e931f6ca3093786181c9fa95"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1777-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "53f47f12011e1656dc67e9e21d1e03aa5a48714a85f28d3183b301af1657d7db"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1777-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "f5eaaf983534fe276da974ec53e4849e97bc40908b98904abffefe17ac7bf7cf"
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
