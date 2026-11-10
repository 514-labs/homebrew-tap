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
  version "0.5.1706-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1706-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "d0b8e45b5c0b4f58fd52594b823e29fbf466c2581e65cd7a1e9682de6369c184"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1706-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "ffb4ec6d25c9f2d67b68f96a240a8cd9d5be5502fa161eb174527f8c6643dc0d"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1706-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "719210f2a8866dbad6098c677de6e307ab39c20922c6a997c48a0552abd2b840"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1706-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "e704bd33f96d17102358242aa240ff017315d8c4b0c1cfd800f75431205c2b42"
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
