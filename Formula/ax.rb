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
  version "0.5.1430-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1430-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "89b38404bbe4bdf3d8aa0ccf5b91eafe30a65701d336b01e93f6ca8e798848aa"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1430-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "c8b585c0b1101173481e0f6ba0564dd175200242654c40ec41e239fec63f3f53"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1430-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "c90ea42e4b8841e6ba15a0a3562fc1bd0322efcc5533070aee8e98e493a328f2"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1430-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "958b09dfb602a8946612a90ef2cc071348f2ee1debf12d39c874bd1262117e43"
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
