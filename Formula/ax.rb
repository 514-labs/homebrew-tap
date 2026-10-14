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
  version "0.5.1345-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1345-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "130fdb23b8353f891eb3e510acf5df86f9b097b00795ee730f8d3833e560fe7c"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1345-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "9a170a3b2be30d77df319767da0fa324d78740c72b4bfe4d4393cd007f9be6fa"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1345-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "4eeadfbb799f9e1e230ba5990acdbdcfc79322895230dff24378e505b5f0607b"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1345-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "23b52c25f2fd08a3986d77ef3607fcb7813c8507d42f9e493e8b16334eb0f1b2"
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
