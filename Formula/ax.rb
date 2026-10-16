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
  version "0.5.1377-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1377-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "d3a87d1cb214861c83a3a605f41f4f270c167d5bbc2d8f09ff0e6ac7a2b4e465"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1377-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "7b840fc4e37e3045e131e7f88e8ca986f0dc3d396f8381850e42012fcaccbed2"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1377-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "10833494f1c6092de294f01045cb567bcb86fb49268d82c696e963816b85f98a"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1377-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "a9d6579a0bbb337a4e6da11e5c952d38f32e329e0b30b667008bbe1ef89179db"
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
