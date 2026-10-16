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
  version "0.5.1382-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1382-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "40412973f7880ed72b39e2605eca7c7dc4f7d0820360271f796066b747d749f2"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1382-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "bd97e8f9af8143198a868fd4cf6c5d8cb891cad4729270b7c3ab3cfa81949a64"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1382-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "94d733ec77c1c2220b03494f3ed7f8d842c5ba089e943bf9a6403d1f00d0f662"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1382-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "2c1a611c5b014a91864cbe5df4e5b119f0f8b95cdfa1656da13b03d8dbbf6572"
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
