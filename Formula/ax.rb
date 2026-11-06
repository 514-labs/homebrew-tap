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
  version "0.5.1674-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1674-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "b81699e9d81ee3d3070b58b22881bbc13841e7ff5bd64a17098a591c2231c3cb"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1674-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "5c1848a8adb7cb37c4cd99186d2b303908d62c9fb812117289f40275801a7584"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1674-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "614f2ff0a73cba091f8faf046f1702a248302cdceb8a918787242def4922eaf5"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1674-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "748c45fa345463dd5bb23e3f3716a72249e8edbd106eda3fbb184a278aa5a338"
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
