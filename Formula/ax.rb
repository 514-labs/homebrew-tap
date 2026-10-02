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
  version "0.5.1227-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1227-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "66ab50351b3611c1e6563fb630ce61c7ca3cc26de9ef22bd03b6db35269b0385"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1227-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "a2161d2d7c9d7855e6bac34d7c57df2a68f479eef04f066f8924a8141c1de9c0"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1227-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "055dff5f73a85860f172aaef4daba9998a7437506a6039e0295ef6e971a2de37"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1227-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "2287d98b776c00bff60f1724c3a0472ed14313a734eb4513548fe890e3e3f19b"
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
