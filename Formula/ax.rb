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
  version "0.5.1411-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1411-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "bc706e7b808df29f3d4939d4fa9687d081f31cba9d5c2cd454dbc25bbaaa76bd"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1411-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "7c2afc04840cd37eb7ed4f9a2ff2b35ab4b28590489007a9e15edbad2e0ecbe7"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1411-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "93b0f922fd86015b6d4a6b45c57c799b3a2b3483afd433712f5cc84e09332088"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1411-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "13967b4fdd4aaa70ab20e1c0713bb16061ccc19898dd718069d9f18d7cbb3b48"
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
