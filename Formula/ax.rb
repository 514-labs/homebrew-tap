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
  version "0.5.1281-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1281-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "7c27257f0062a05a4b9cd7f8baba67cd772377e9e3cbfd8f1031d2d61c48339b"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1281-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "81047c39e92c9e1cac9a7b770a4daf25b305b0106bccda8ed2b2816bef0478c0"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1281-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "ab1c2fab46465733f060e79a5817b9c119af6933348e37c62d8ecd3eec8d0898"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1281-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "4bdce69a8f3898d7a68bf0450f059ce96b6439c7c54ce9de0d5c11645fc20771"
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
