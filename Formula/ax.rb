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
  version "0.5.1799-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1799-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "27e4c9638f48c42e7660522eae6cdb41e61c949a86233ed13e8eb2ae45db5188"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1799-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "b732a47044479c7d7e7a899eb8ba0ddf5c9ccace92f9416c168bad6ff46da3e3"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1799-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "088cfc3e9a118f1a21a949a4cf5b285591a0e4744997f62939c4f9e1da3367c0"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1799-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "0a82dc5bb65d5d2fac549b074b6680c074be82a10fb9bf60907572b7af346273"
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
