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
  version "0.5.1474-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1474-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "61215ae1c389077ff390b703eff6f1f6738b05836889a078e488e1fd3110d024"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1474-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "1d38b542282434fa5a32a05f3789c8e92b4921da08903e12cf26f0cfa5d3dfc1"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1474-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "847915dc5ec2c0e862a0a0346bcebcf3b9313eccbb3ccb5dfefa7eb9d29a194a"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1474-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "d1271080cc74ee4623f64a80073110d30d13a3284e3dda369eecce8da0c752a7"
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
