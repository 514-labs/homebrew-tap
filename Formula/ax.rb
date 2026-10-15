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
  version "0.5.1367-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1367-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "71cd2466190434b8015acd4829e1ca9f475727fcea9480de23887de402d52727"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1367-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "7e6158b71905a70930329cd037d74fba0778287e800780c695fe184cd1a5c820"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1367-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "1b221cb8283c6cbbcd0c0418da3a08fd99c7e990ec7ce95e5e509502a7e58aa8"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1367-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "ae5108765744abc4e3b194bc108b2a12a63593610ccbf2e2de276b794c615f3d"
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
