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
  version "0.5.1298-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1298-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "8d2753117716b20a8905812116e5e2ad081d00c8e0768cd67529b3052c2c4cb1"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1298-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "82b4484325085745d6b5c7afba256368bd360fb6a780c8dde28d9d35fcaaeafa"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1298-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "a5045e4f51dc0c95717d3fb66bba8e289495f26a7fada0303d8ea5c39e0c983a"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1298-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "809651f209e3de264e74846e960c8ec670f434758715afb4c1bb0b71b9cfba4e"
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
