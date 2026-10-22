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
  version "0.5.1455-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1455-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "697737de4999d5e889b0827f2fd9c951f81ba40f09f4b846ae2af54c98988d7d"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1455-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "d86620f6df5342eac123a320dba259a91a41d1a0eea4a36bf26d6b4794fa160d"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1455-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "64872095ef1043ce05c228694a98290438e897d2179941e3f4cb4d27eb604bd7"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1455-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "424cb79a9bdb2bc27125c5f89cf6c34da5c7846e9da15132f611d5eaf19b8e82"
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
