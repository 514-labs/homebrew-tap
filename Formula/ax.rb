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
  version "0.5.1732-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1732-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "6ca652b18dd881076692cc52512f0bdc239b7164845feab02d1716bccb1ac433"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1732-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "33ab3b28d5bc834972eecc5ba79b84f9bd95083e5a90806f4bb9de80afcbd43b"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1732-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "ef8c9ef597c4c2afd852f34fefbbc35ab335d957778dc89eb3a7ed516f42aeaf"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1732-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "3571454bf0d8cec7bfd636d64bc63c7c5fa368b0f0c6decf42116aeb527359f4"
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
