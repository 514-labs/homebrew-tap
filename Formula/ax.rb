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
  version "0.5.1287-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1287-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "31f0655c24e385d69f03ffdbece6ba5686bb1423e265f3bec5d9e3cb5ff2fb27"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1287-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "7f1a16ea8eaa3c093b52dc1fd544d2e5fb019637c3f0e766c1fe1a8708ec9f99"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1287-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "1049fb99eb25ea1a0138af21d6dc7a3bd83dfd09ea9bceb7b6881a375fb69a7c"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1287-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "9e9a91de6bddd5977f745b64e995bf5024de2e3e7386104a539feec2befa4533"
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
