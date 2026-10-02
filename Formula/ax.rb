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
  version "0.5.1230-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1230-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "3f076e41c250f5dd4922b4dc632c8b9d6a178bfbd7dc1f277df1453e8afa7d32"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1230-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "fe9b53808c3d455c2c17a20ad485b1fc9956688f1f30c58fba4b87916cf7feab"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1230-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "f5513f0bff8149c4bb604f3b98078e3ce8c128bf3b639200b7c7e3f9ed872d1f"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1230-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "32c2aed0c2d77b480cdc9b340539c2083b646816d8170c68298cc5ef8c0761f5"
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
