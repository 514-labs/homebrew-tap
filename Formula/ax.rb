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
  version "0.5.1438-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1438-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "8b9a9bf35befe104b35f1bec7b9de07d105a6fe9cd444f35cd15ccdd9f3d3d1a"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1438-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "8856440da1cd59456771c3f9416344fb4f6b5d53cb288b6a5dc17b0ce29efdab"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1438-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "f785c99d3cbff3222e9d182bfb977b073f87d46d58220462a63de5c2ab72b8e2"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1438-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "593268dc9e6a40c4e04f6921adf39d2de0c078260d639dfa43672e687011e149"
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
