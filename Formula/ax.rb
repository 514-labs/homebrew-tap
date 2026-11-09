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
  version "0.5.1702-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1702-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "6572b964efb5276bbac2952bab7aab3beb31406f76df7559a9fde65cd1cb0211"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1702-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "c57c75fcace93a32921729867c3972ca541457f1a2edc85611bf55df2747cf7e"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1702-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "54bbc8b72bc3f4d41530283c275e0cfee51229dea7ee60cd376cc89f951bb895"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1702-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "edd61028d0694f5e68b527c6f425431aa5b7e00b4c92a07f1f0ef7d1162f2aa1"
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
