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
  version "0.5.1356-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1356-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "2ca4f0edeaab30b50e4be3e7772098a6ae15094b2b077ea296d14f151001c06b"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1356-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "729e9e187eb484cda2853058a938832660a30a61d854e20192a0595bd66422d6"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1356-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "2af40adfc6876a0249946f96c94ec29d9c6ebc8fe5d5d70218010452089b2ffa"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1356-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "0fff328ba8a805467cbd3ca1b99d747caebb5e0363f11a0c403441261078fbfb"
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
