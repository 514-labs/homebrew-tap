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
  version "0.5.1771-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1771-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "d402e8091f94552433d5558e85b43d148d8c1f5f4df8374529440dff2af8e289"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1771-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "31d4808725f3e7a04747aad229967285bb64c2694a394bdc9d31e5a6476dc039"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1771-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "b3a7698fa9e505d7cf15203245aca352376e3a3b56ede566fdc97ec3dfa42ca0"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1771-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "7dcef3463fb7f8455ff85242b75236bf48e331cad5397780e088f8aaa599e2fe"
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
