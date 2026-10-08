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
  version "0.5.1290-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1290-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "14e0038284101f713d68481b81eab8a15f153ebfee244919d5548081513f3a62"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1290-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "d8b2a665ef0d5084a86e21bc73734e0df00eb979e759382dbb9bc704d36be89f"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1290-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "135f8b0cf494c7feacbf177bde7df0bf40f61943200a6f6f128123f6591870cb"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1290-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "80f5aef849e2b5cbbc4393745241cf7767c2d04c31f18ae38a978a805c076d1a"
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
