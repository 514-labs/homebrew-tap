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
  version "0.5.1660-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1660-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "0ff78f58f0ea8d16118f5f368c2fc3666af7aeac43e4a417f22473c76289126a"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1660-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "e06ab49576ea7bba6f72423aa2a89d5b2d6a8e1511db5d53e36f9597d7f144ac"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1660-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "51ed5a06fa51f7e603f41d7a26f5298c293015537c4ced516731697fbc094da1"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1660-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "35e3258b7f1df890535d42c91d5a3e6818f1fbfe9b6c516071a419e896510fad"
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
