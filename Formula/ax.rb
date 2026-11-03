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
  version "0.5.1633-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1633-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "7217ee7a7719dc07446094b68eb3698891e9b52b8e1963d7c56728e9adbeff30"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1633-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "63afd097e4ec660000a928bde92cd1f1894d86e159e50ad96525a105b80fdcdb"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1633-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "cafd5b8b29ecda06c9dc32db28086664d8a3790a40b127e7b1e57bb7d02e8fb4"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1633-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "c973a37a25498b3d649924b3e1b96ae40adf63eaaaacb4b1d1bd933a6e2bed15"
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
