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
  version "0.5.1745-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1745-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "9d7da279963ab8b4ab868faf86b599e48ec6f3790e0d69e0bceb00f9f76aa6c6"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1745-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "e2116e0fb7062656b1224543b20f642488309bf7328c9ed5284c8123fef1e64b"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1745-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "2ca4764e15eb1eea1746aed570ffa216b05ac1667219807dfca4bf145e139cfc"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1745-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "d687e035bd83010dcc80479b305ce05096d66928655e86904fefb7289db7c86c"
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
